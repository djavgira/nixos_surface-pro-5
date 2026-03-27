{ config, lib, pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./syncthing.nix
    ./gaming.nix
  ];
}
