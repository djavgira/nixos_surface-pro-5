#!/usr/bin/env bash
# 更新 Denial 输入并重建系统，同时确保不会重新编译 linux-surface 补丁内核。
#
# 背景：触屏用的补丁内核（hardware.microsoft-surface，6.19.8）不在任何二进制缓存里，
# 只能从源码编译。只要宿主 nixpkgs 不变，它的 derivation 就不变，会直接复用已经构建
# 好的结果；而 `nix flake update`（不带输入名）会连带升级 nixpkgs，从而触发数小时的
# 内核编译。Denial 使用自己 flake 里锁定的 nixpkgs，升级它不需要动宿主 nixpkgs。
#
# 用法:
#   scripts/update-denial.sh              # 更新 denial 输入并重建系统
#   scripts/update-denial.sh --no-rebuild # 只更新并校验，不重建
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

rebuild=true
if [[ "${1:-}" == "--no-rebuild" ]]; then
  rebuild=false
fi

kernel_drv() {
  nix eval --raw --accept-flake-config \
    ".#nixosConfigurations.nixos.config.boot.kernelPackages.kernel.drvPath"
}

before="$(kernel_drv)"
echo "当前补丁内核: $(basename "$before")"

nix flake update denial

after="$(kernel_drv)"
if [[ "$before" != "$after" ]]; then
  echo "警告: 内核 derivation 已变化，这次重建会重新编译内核（数小时）:" >&2
  echo "  $before" >&2
  echo "  -> $after" >&2
else
  echo "内核未变化，内核与内核补丁都会被复用，不会重新编译。"
fi

if [[ "$rebuild" == true ]]; then
  sudo nixos-rebuild switch --flake .#nixos --accept-flake-config
fi
