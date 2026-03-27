{ config, lib, pkgs, ... }:

{
  hardware.microsoft-surface.kernelVersion = "stable";
  # hardware.microsoft-surface.ipts.enable = true;
  # hardware.microsoft-surface.surface-control.enable = true;

  virtualisation.vmware.guest.enable = true;
}
