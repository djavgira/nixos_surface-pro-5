{
  
  description = "Pain_Wind's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; 
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    llm-agents.url = "github:numtide/llm-agents.nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
     
   };
};

  outputs = inputs@{ self, nixpkgs, nixos-hardware , home-manager , ... }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
	inherit inputs;
      };
      modules = [
        ./nix/configuration.nix
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

