{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }:
    let
      globalVars = {
        username = "luis";
        homeDirectory = "/home/luis";
        system = "x86_64-linux";

        wallpaperDir = "/home/luis/Images/Wallpapers"; # Absolute path
        wallpaperRelativePath = "Images/Wallpapers"; # Relavite to the home

        notesDir = "/data/notas";
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit (globalVars) system;
          specialArgs = { 
            inherit globalVars sops-nix home-manager; 
          };

          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops 
            ./hosts/laptop/default.nix
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          inherit (globalVars) system;
          specialArgs = { 
            inherit globalVars sops-nix home-manager; 
          };

          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops 
            ./hosts/server/default.nix
          ];
        };
      };

      devShells.${globalVars.system} = import ./shells {
        pkgs = nixpkgs.legacyPackages.${globalVars.system};
      };
    };
}