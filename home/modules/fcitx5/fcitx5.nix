{ config, lib, pkgs, inputs, ... }:

let
  # 完整版：内置 sherpa-onnx 本地离线识别
  fcitx5-vinput = inputs.fcitx5-vinput.packages.${pkgs.stdenv.hostPlatform.system}.default;
  # 极简版：纯云端 ASR + LLM，无本地 ONNX 运行时
  # fcitx5-vinput = inputs.fcitx5-vinput.packages.${pkgs.stdenv.hostPlatform.system}.fcitx5-vinput-lite;
in
{
  # 提供 vinput / vinput-gui / vinput-daemon 命令
  environment.systemPackages = [ fcitx5-vinput ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      # 桌面会话运行在 Wayland 下，由 fcitx5 的 Wayland 前端接管输入
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-vinput
        qt6Packages.fcitx5-qt
        qt6Packages.fcitx5-chinese-addons
        fcitx5-rime
      ];
    };
  };

  # 官方二进制缓存：主 flake 里的 nixConfig 对非信任用户会被 Nix 忽略，
  # 写进系统配置后 nixos-rebuild 会直接下载预编译产物，
  # 不必从源码编译 sherpa-onnx 与 ONNX 运行时。
  nix.settings = {
    extra-substituters = [ "https://fcitx5-vinput.cachix.org" ];
    extra-trusted-public-keys = [
      "fcitx5-vinput.cachix.org-1:XpX3AA6+dDIX4qJhb1QM7sbTwX6/qSlGvW8Z5NK6XdU="
    ];
  };

  # 语音识别后台服务，提供 org.fcitx.Vinput DBus 接口，随用户会话启动
  systemd.user.services.vinput-daemon = {
    description = "Vinput Voice Input Daemon";
    after = [ "pipewire.service" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "dbus";
      BusName = "org.fcitx.Vinput";
      ExecStart = "${fcitx5-vinput}/bin/vinput-daemon";
      Restart = "on-failure";
      RestartSec = 2;
    };
  };
}
