{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    zip
    unzip
    fd
    zoxide
    nixos-generators
    openjdk
    jetbrains.idea
    vscode
    neovim
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
