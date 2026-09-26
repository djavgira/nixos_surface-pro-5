# nixos_surface-pro-5

我的 NixOS 配置，适用于 Surface Pro 5。

桌面环境使用 [Denial](https://github.com/denialwm/denial)（Flutter + Rust 的 Wayland 合成器），通过 flake 输入 `github:denialwm/denial` 与 `denial.nixosModules.default` 集成；登录管理器仍使用 GDM，在会话菜单中选择 Denial 即可。

![NixOS](images/nixos_femal.jpg)

## 文件树

```bash
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
│   │   ├── denial.nix
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
