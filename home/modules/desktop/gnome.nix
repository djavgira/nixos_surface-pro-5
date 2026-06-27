{ config, lib, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # 删除不需要的 GNOME 应用
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    yelp
    gnome-maps
    gnome-contacts
    gnome-calendar
    cheese
    gnome-music
    gnome-terminal
    gedit
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ];
}
