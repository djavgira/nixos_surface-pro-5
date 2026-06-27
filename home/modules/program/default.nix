{ config, lib, pkgs, ... }:

{
  imports = [
#    ./cloudflared.nix
    ./hexo.nix
    ./dev.nix
    ./syncthing.nix
    ./gaming.nix
#    ./mihomo.nix
    ./minio-client.nix
  ];
}
