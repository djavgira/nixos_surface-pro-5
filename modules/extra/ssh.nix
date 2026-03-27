{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "bob" ];
    };
  };

  users.users."bob".openssh.authorizedKeys.keyFiles = [
    ./../../ssh/id_ed25519.pub
  ];
}
