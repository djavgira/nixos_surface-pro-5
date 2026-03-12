# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [	
      <nixos-hardware/microsoft/surface/surface-pro-intel>
      ./hardware-configuration.nix
    ];
  hardware.microsoft-surface.kernelVersion = "stable";
  # hardware.microsoft-surface.ipts.enable = true;
  # hardware.microsoft-surface.surface-control.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  nixpkgs.config.allowUnfree = true ;
  virtualisation.vmware.guest.enable = true;


 # nixpkgs.overlays = [
 #  (final: prev: {
 #    librime = (prev.librime.override {
 #      plugins = [
#           (pkgs.fetchFromGitHub {
#             owner = "hchunhui";
#             repo = "librime-lua";
#             rev = "e3912a4b3ac2c202d89face3fef3d41eb1d7fcd6";
#             sha256 = "sha256-zx0F41szn5qlc2MNjt1vizLIsIFQ67fp5cb8U8UUgtY=";
#           })
 #          pkgs.librime-lua
 #          pkgs.librime-octagram
 #      ];
 #    }).overrideAttrs (old: {
 #      buildInputs = (old.buildInputs or []) ++ [pkgs.luajit]; # 用luajit
#         buildInputs = (old.buildInputs or []) ++ [pkgs.lua5_4]; # 用lua5.4
 #    });
 #  })
 #];

  #fcitx5

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
          fcitx5-gtk
	  qt6Packages.fcitx5-qt
	  qt6Packages.fcitx5-chinese-addons
	  #rime
	  fcitx5-rime
	  rime-data
      ];
    
  };
 

  # Configure network proxy if necessary

# Fcitx5 环境变量

#  environment.sessionVariables = {
#    GTK_IM_MODULE = lib.mkForce "fcitx5";
#    QT_IM_MODULE = lib.mkForce "fcitx5";
#    XMODIFIERS = lib.mkForce "@im=fcitx5";
#};
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bob = {
    isNormalUser = true;
    description = "bob";
    extraGroups = [
     "networkmanager"
     "wheel"
       ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nix.settings.substituters = [     
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://cache.nixos.org/"
  ];

  #delete no nesscery
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    yelp
    gnome-maps
    gnome-contacts
    gnome-calendar
    cheese
    gnome-music
    gnome-terminal
    gedit   
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ];

  environment.systemPackages = with pkgs; [
   vim 
   wget
   curl
   git
   qq
   zip
   unzip
   kitty
   fcitx5
   v2ray
   wqy_zenhei
   neovim
   openjdk
   jetbrains.idea
   lutris
   vscode
   steam
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
        };

  services.openssh.enable = true;
  
  # user.user.root.openssh.anthorizedKeys.keys = [""];

  # user.user.bob.opensh.authorizedKeys.keys = [""];

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
    };
    
};

  system.stateVersion = "25.11";

}
