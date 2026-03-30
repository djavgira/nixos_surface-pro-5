{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # 国内镜像源
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://cache.nixos.org/"
  ];
  ervices.mihomo = {
  enable = true;
  configFile = "/home/bob/.config/clash-meta/config.yaml";
  #...
};
}
