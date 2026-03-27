# nixos_surface-pro-5
我的文件树

.
├── configuration.nix
├── flake.lock
├── flake.nix
├── hardware-configuration.nix
├── home.nix
├── modules
│   ├── core
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── network.nix
│   │   └── users.nix
│   ├── default.nix
│   ├── desktop
│   │   ├── default.nix
│   │   ├── gnome.nix
│   │   └── sound.nix
│   ├── extra
│   │   ├── default.nix
│   │   ├── gc.nix
│   │   └── ssh.nix
│   ├── fcitx5
│   │   ├── default.nix
│   │   └── fcitx5.nix
│   ├── hardware
│   │   ├── default.nix
│   │   └── surface.nix
│   └── program
│       ├── default.nix
│       ├── dev.nix
│       ├── gaming.nix
│       └── syncthing.nix
├── README.md
└── ssh
    ├── id_ed25519
    └── id_ed25519.pub
