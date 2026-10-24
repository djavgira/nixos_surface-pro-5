{ config, lib, pkgs, ... }@inputs:

let
  # Full version (default):
  fcitx5-vinput = inputs.fcitx5-vinput.packages."${pkgs.stdenv.hostPlatform.system}".default;
  # Or Lite version (pure cloud ASR + LLM, zero ONNX runtime):
  # fcitx5-vinput = inputs.fcitx5-vinput.packages."${pkgs.stdenv.hostPlatform.system}".fcitx5-vinput-lite;
in
{
  home.packages = [
    fcitx5-vinput
  ];
  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-vinput
      qt6Packages.fcitx5-qt
      qt6Packages.fcitx5-chinese-addons
      fcitx5-rime
      rime-data
    ];
  };
}
