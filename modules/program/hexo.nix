{ config , lib , pkgs, ... }:    

{
  environment.systemPackages = with pkgs; [
    hexo-cli
  ];
}