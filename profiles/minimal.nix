{ config, pkgs, globalVars, ... }:

{
  imports = [
    ../modules/nixos/base.nix
    ../modules/nixos/boot.nix
    ../modules/nixos/networking.nix
    ../modules/nixos/nix.nix
    ../modules/nixos/packages.nix
    ../modules/nixos/users.nix
    ../modules/nixos/variables.nix
  ];

  home-manager.users.${globalVars.username} = { pkgs, ... }: {
    imports = [
      ../modules/home/bash.nix
      ../modules/home/btop.nix
      ../modules/home/colors.nix
      ../modules/home/nvim.nix
      ../modules/home/packages-minimal.nix
      ../modules/home/sops.nix
      ../modules/home/starship.nix
      ../modules/home/udiskie.nix
      ../modules/home/variables.nix
      ../modules/home/vim.nix
      ../modules/home/yazi.nix
    ];

    home = {
      inherit (globalVars) username homeDirectory;
      stateVersion = "25.11";
    };
  };
}