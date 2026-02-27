{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      globalVars = {
        username = "luis";
        homeDirectory = "/home/luis";
        system = "x86_64-linux";

        wallpaperDir = "/home/luis/Images/Wallpapers"; # Absolute path
        wallpaperRelativePath = "Images/Wallpapers"; # Relavite to the home
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit (globalVars) system;
          specialArgs = { inherit globalVars; } // { inherit home-manager; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/laptop/default.nix
          ];
        };
      };

      devShells.${globalVars.system} = import ./shells {
        pkgs = nixpkgs.legacyPackages.${globalVars.system};
      };
    };
}