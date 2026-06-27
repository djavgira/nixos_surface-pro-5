{ config, lib, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Flakes 支持
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
