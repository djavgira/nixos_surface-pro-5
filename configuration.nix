# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, options, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/default.nix
  ];

  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  # 系统基础设置
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # 打印服务
  services.printing.enable = true;

  # 软件包（用户级已移到 home-manager）
  environment.systemPackages = with pkgs; [
    starship
    zsh-syntax-highlighting
    zsh-autosuggestions
    qq
    v2ray
    wqy_zenhei
    zerotierone
    syncthing
  ];

  programs.firefox.enable = true;

  system.stateVersion = "25.11";
}
