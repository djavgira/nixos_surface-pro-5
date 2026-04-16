{ config, lib, pkgs, ... }:

{
  imports = [
    ./hexo.nix
    ./dev.nix
    ./syncthing.nix
    ./gaming.nix
#    ./mihomo.nix
  ];
}
