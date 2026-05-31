{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minio-client
  ];

    nix = {
    settings = {
      extra-substituters = [
        "http://192.168.10.123:9000/nix-cache/"
      ];
      extra-trusted-public-keys = [
        "debian-minio:6Xlh7HlmWgPuqb3JCiMwNy3FphzuQIgg6/lhLEaMd6o="
      ];
    };
  };

}
