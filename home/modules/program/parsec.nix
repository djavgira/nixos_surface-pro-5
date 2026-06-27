{ lib , config , pkgs ... }

{
  environment.systemPackages = with pkgs ;[
    parsec-bin
  ]
}