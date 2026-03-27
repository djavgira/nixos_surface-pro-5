{ config, lib, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings = {
      devices = {
        "device1" = { id = "H6YADMR-ERLYF7I-C437Y5H-KPHY4T4-ILWJLGY-AAF7A4G-VDQ6END-G6ZFHAH"; };
      };
      folders = {
        "Documents" = {
          path = "/home/bob/Documents/共享文件夹surface";
          devices = [ "device1" ];
        };
      };
    };
  };
}
