{ config, pkgs, globalVars, ... }:

{
  imports = [
    ../modules/nixos/base.nix
    ../modules/nixos/boot.nix
    ../modules/nixos/networking.nix
    ../modules/nixos/nix.nix
    ../modules/nixos/packages.nix
    ../modules/nixos/services.nix
    ../modules/nixos/security.nix
    ../modules/nixos/users.nix
    ../modules/nixos/variables.nix
  ];

  home-manager.users.${globalVars.username} = { pkgs, ... }: {
    imports = [
      ../modules/home/bash.nix
      ../modules/home/btop.nix
      ../modules/home/cliphist.nix
      ../modules/home/colors.nix
      ../modules/home/foot.nix
      ../modules/home/gtk.nix
      ../modules/home/kanshi.nix
      ../modules/home/mako.nix
      ../modules/home/nvim.nix
      ../modules/home/packages-desktop.nix
      ../modules/home/river.nix
      ../modules/home/starship.nix
      ../modules/home/swappy.nix
      ../modules/home/swaylock.nix
      ../modules/home/udiskie.nix
      ../modules/home/variables.nix
      ../modules/home/vim.nix
      ../modules/home/wallpapers.nix
      ../modules/home/waybar.nix
      ../modules/home/wofi.nix
      ../modules/home/yazi.nix
    ];

    home = {
      inherit (globalVars) username homeDirectory;
      stateVersion = "25.11";
    };
  };
}