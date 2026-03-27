{ config, lib, pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./gc.nix
  ];
}
