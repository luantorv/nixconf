{ config, pkgs, ... }:

{
  imports =
  [
    ./modules/colors.nix
    ./modules/home-manager.nix
    ./modules/packages.nix
    ./modules/variables.nix
    
    ./modules/river.nix
    ./modules/swaylock.nix
    ./modules/kanshi.nix
    ./modules/bash.nix
    ./modules/cliphist.nix
    ./modules/foot.nix
    ./modules/gtk.nix
    ./modules/vim.nix
    ./modules/waybar.nix
    ./modules/wofi.nix
  ];
  
  home.username = "luis";
  home.homeDirectory = "/home/luis";
  home.stateVersion = "25.11";
}
