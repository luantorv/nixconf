{ config, pkgs, globalVars, ... }:

{
  imports = [
    ../modules/nixos/core/base.nix
    ../modules/nixos/core/nix.nix
    ../modules/nixos/boot/systemd-boot.nix
    ../modules/nixos/packages.nix
    ../modules/nixos/users.nix
    ../modules/nixos/variables.nix
  ];

  home-manager.users.${globalVars.username} = { pkgs, ... }: {
    imports = [
      ../modules/home/packages/minimal.nix

      ../modules/home/editors
      ../modules/home/files

      ../modules/home/shell/bash.nix
      ../modules/home/terminal/btop.nix
      ../modules/home/theme/colors.nix
      ../modules/home/sops.nix
      ../modules/home/variables.nix
    ];

    home = {
      inherit (globalVars) username homeDirectory;
      stateVersion = "25.11";
    };
  };
}