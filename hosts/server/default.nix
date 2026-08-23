# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, pkgs-old, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./docker.nix
    ../../modules/home/sops.nix
    ../../profiles/minimal.nix
    ../../modules/nixos/server.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit globalVars sops-nix pkgs-old; };
    sharedModules = [ sops-nix.homeManagerModules.sops ];
    backupFileExtension = "backup";
  };

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "server";
}
