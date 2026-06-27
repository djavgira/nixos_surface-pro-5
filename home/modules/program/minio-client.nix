{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minio-client
  ];

    nix = {
    settings = {
      extra-substituters = [
        "s3://nix-cache?region=guetsec-pve&endpoint=http://192.168.10.32:9000/nix-cache/"
      ];
      extra-trusted-public-keys = [
      	"s3.homelab.local-1:odBG/MiuZFzLwFV5+JZq7ArvIza5SgnY7aPrLQncx10="
      ];
    };
  };

}
