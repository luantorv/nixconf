# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, nixpkgs-old, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./docker.nix
    ../../modules/home/sops.nix
    ../../profiles/river.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit globalVars sops-nix nixpkgs-old; };
    sharedModules = [ sops-nix.homeManagerModules.sops ];
  };

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nichos";
}
