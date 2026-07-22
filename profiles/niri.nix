# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, noctalia, ... }:

{
  imports = [
    ../modules/nixos/core
    ../modules/nixos/boot/grub.nix
    ../modules/nixos/greetd.nix

    ../modules/nixos/packages.nix
    ../modules/nixos/services.nix
    ../modules/nixos/security.nix
    ../modules/nixos/users.nix
    ../modules/nixos/variables.nix
  ];

  programs.niri.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  home-manager.sharedModules = [ noctalia.homeModules.default ];

  home-manager.users.${globalVars.username} = { pkgs, ... }: {
    imports = [
      ../modules/home/packages/niri.nix

      ../modules/home/niri
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
