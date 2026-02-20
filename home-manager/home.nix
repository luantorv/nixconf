{ config, pkgs, ... }:

{
  imports =
  [
    ./modules/home-manager.nix
    ./modules/packages.nix
    ./modules/variables.nix
    ./modules/colors.nix

    ./modules/river.nix
    ./modules/kanshi.nix
    ./modules/mako.nix
    ./modules/bash.nix
    ./modules/starship.nix
    ./modules/nvim.nix
    ./modules/vim.nix
    ./modules/foot.nix
    ./modules/gtk.nix
    ./modules/waybar.nix
    ./modules/wofi.nix
    ./modules/yazi.nix

    ./modules/cliphist.nix
    ./modules/swappy.nix
    ./modules/swaylock.nix
  ];
  
  home.username = "luis";
  home.homeDirectory = "/home/luis";
  home.stateVersion = "25.11";
}
