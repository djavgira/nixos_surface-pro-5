{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./network.nix
    ./users.nix
  ];
}
