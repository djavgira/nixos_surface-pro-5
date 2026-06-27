{ lib , pkgs, ... }:    #未启用

{
  environment.systemPackages = with pkgs; [
    nodePackages.
  ];
  
  programs.nodejs = {
    enable = true;
    package = pkgs.nodejs_18_x;
  };
}