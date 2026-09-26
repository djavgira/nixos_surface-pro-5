# nixos_surface-pro-5

我的 NixOS 配置，适用于 Surface Pro 5。

桌面环境使用 [Denial](https://github.com/denialwm/denial)（Flutter + Rust 的 Wayland 合成器），通过 flake 输入 `github:denialwm/denial` 与 `denial.nixosModules.default` 集成；登录管理器仍使用 GDM，在会话菜单中选择 Denial 即可。

![NixOS](images/nixos_femal.jpg)

## 更新 Denial（跳过补丁内核构建）

触屏用的 linux-surface 补丁内核（由 `hardware.microsoft-surface` 提供，6.19.8）不在任何二进制缓存里，只能源码编译；只有宿主 nixpkgs 不变时，才能复用已经构建好的内核。所以更新 Denial 时不要用 `nix flake update`（它会连带升级 nixpkgs，触发数小时的内核编译）：

```sh
scripts/update-denial.sh              # 只更新 denial 输入 + 校验内核未变 + nixos-rebuild switch
scripts/update-denial.sh --no-rebuild # 只更新并校验
```

脚本会先记录 `boot.kernelPackages.kernel.drvPath`，更新 denial 之后再比对，内核 derivation 一旦变化会明确告警。确实需要升级 nixpkgs 时：

```sh
nix flake update nixpkgs              # 补丁内核会重新编译（官方文档建议预留 >48 GiB 空间）
sudo nixos-rebuild switch --flake .#nixos
```

首次重建建议加上 `--accept-flake-config`，让 root 构建时用上 flake 里的 denial.cachix.org 缓存，避免从源码编译 Flutter 引擎（之后 `/etc/nix/nix.conf` 已带上该缓存，可以不加）。

## 文件树

```bash
.
├── configuration.nix
├── flake.lock
├── flake.nix
├── hardware-configuration.nix
├── home.nix
├── modules
│   ├── core
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── network.nix
│   │   └── users.nix
│   ├── default.nix
│   ├── desktop
│   │   ├── default.nix
│   │   ├── denial.nix
│   │   └── sound.nix
│   ├── extra
│   │   ├── default.nix
│   │   ├── gc.nix
│   │   └── ssh.nix
│   ├── fcitx5
│   │   ├── default.nix
│   │   └── fcitx5.nix
│   ├── hardware
│   │   ├── default.nix
│   │   └── surface.nix
│   └── program
│       ├── default.nix
│       ├── dev.nix
│       ├── gaming.nix
│       └── syncthing.nix
├── README.md
├── scripts
│   └── update-denial.sh
└── ssh
    ├── id_ed25519
    └── id_ed25519.pub
