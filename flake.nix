{
  description = "Pain_Wind's NixOS Flake";

  # Denial 作为 flake 输入使用时，Nix 不会应用它自己的 nixConfig，
  # 因此在这里重复它的二进制缓存与签名公钥。
  nixConfig = {
    extra-trusted-public-keys = [
      "fcitx5-vinput.cachix.org-1:XpX3AA6+dDIX4qJhb1QM7sbTwX6/qSlGvW8Z5NK6XdU="  
      "denial.cachix.org-1:wd8YTnvPmugFrtdMJWtR1XdVknR3/g2nmBJkT+vAruo="
    ];
    extra-substituters = [ 
      "https://fcitx5-vinput.cachix.org" 
      "https://denial.cachix.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    llm-agents.url = "github:numtide/llm-agents.nix";
    denial.url = "github:denialwm/denial";
    fcitx5-vinput = {
      url = "github:xifan2333/fcitx5-vinput";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, nixos-hardware, home-manager, llm-agents, denial, ... }:
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          #  inherit inputs;
          #  inherit llm-agents;
          #  inputs = inputs;
          llm-agents = llm-agents;
        };
        modules = [
          ./nix/configuration.nix
          denial.nixosModules.default
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bob = import ./home/home.nix;
          }
        ];
      };
    };
}
