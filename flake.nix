# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs-new.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs-new";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-new, nixpkgs-old, home-manager, sops-nix, noctalia, plasma-manager, ... }:
    let
      globalVars = {
        username = "luis";
        homeDirectory = "/home/luis";
        system = "x86_64-linux";
        stateVersion = "26.05";

        wallpaperDir = "/home/luis/Images/Wallpapers"; # Absolute path
        wallpaperRelativePath = "Images/Wallpapers"; # Relavite to the home

        notesDir = "/data/notas";
      };

      pkgs-old = import nixpkgs-old {
        inherit (globalVars) system;
        config.allowUnfree = true;
      };

      pkgs-new = import nixpkgs-new {
        inherit (globalVars) system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit (globalVars) system;
          specialArgs = {
            inherit globalVars sops-nix home-manager pkgs-old pkgs-new noctalia plasma-manager;
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
            inherit globalVars sops-nix home-manager pkgs-old; 
          };

          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            ./hosts/server/default.nix
          ];
        };
      };
    };
}
