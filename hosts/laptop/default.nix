# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, pkgs-new, pkgs-old, plasma-manager, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./docker.nix
    ../../modules/home/sops.nix
    ../../profiles/plasma.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit globalVars sops-nix pkgs-new pkgs-old; };
    sharedModules = [ sops-nix.homeManagerModules.sops ];
  };

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nichos";
}
