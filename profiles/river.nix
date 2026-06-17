# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, pkgs-old, ... }:

{
  imports = [
    ../modules/nixos/core
    ../modules/nixos/boot/grub.nix
    
    ../modules/nixos/packages.nix
    ../modules/nixos/services.nix
    ../modules/nixos/security.nix
    ../modules/nixos/users.nix
    ../modules/nixos/variables.nix
    ../modules/nixos/android.nix
  ];

  home-manager.users.${globalVars.username} = { pkgs, pkgs-old, ... }: {
    imports = [
      ../modules/home/packages/river.nix 

      ../modules/home/river
      ../modules/home/desktop
      ../modules/home/editors
      ../modules/home/files
      ../modules/home/shell
      ../modules/home/terminal
      ../modules/home/theme

      ../modules/home/cliphist.nix     
      ../modules/home/sops.nix
      ../modules/home/variables.nix
    ];

    home = {
      inherit (globalVars) username homeDirectory;
    };
  };
}
