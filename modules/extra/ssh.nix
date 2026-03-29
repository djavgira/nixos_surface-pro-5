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

  users.users."bob".openssh.authorizedKeys.keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9iAtMWZd8lQgWFFge0FsdAuaWN42nn4YvEkV4VBh0+ kali@kali"
  ];
}
