{ config, lib, pkgs, ... }:

{
  imports = [
    ./denial.nix
    ./sound.nix
  ];
}
