{ config, lib, pkgs, ... }:

{
  # Denial 由 flake 输入 denial.nixosModules.default 提供。
  # 该模块会注册 Wayland 会话、Settings 门户、Xwayland、polkit、
  # realtime 调度、DDC/I2C 显示器控制与中文字体回退等。
  programs.denial.enable = true;

  # Denial 的模块刻意不启用显示管理器、不选择默认会话、也不配置自动登录。
  # 这里保留现有的 GDM，安装完成后在登录界面选择 Denial 会话即可。
  services.displayManager.gdm.enable = true;

  # Xwayland / GDM 所需的 X 键盘布局（中文）。
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # 合成器本身读取的键盘布局（smithay/wlroots 系通用的环境变量）。
  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "cn";
    XKB_DEFAULT_VARIANT = "";
  };

  # Denial 的官方二进制缓存。主 flake 里的 nixConfig 对非信任用户会被 Nix 忽略，
  # 写进系统配置后，root 执行 nixos-rebuild 时会直接下载官方构建产物，
  # 不必从源码编译 Flutter 引擎（官方文档称缓存未命中需要 >48 GiB 空间）。
  nix.settings = {
    extra-substituters = [ "https://denial.cachix.org" ];
    extra-trusted-public-keys = [
      "denial.cachix.org-1:wd8YTnvPmugFrtdMJWtR1XdVknR3/g2nmBJkT+vAruo="
    ];
  };
}
