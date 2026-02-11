{ config, pkgs, ... }:

# Paleta de colores

let
  nixAzul = "#5277c3";
  nixCeleste = "#7ebae4";
  conNaranja = "#f2a65a";
  conRojo = "#c1495b";
  blanco = "#ffffff";
  negro = "#000000";
  gris = "#888888";
in

{
  imports =
  [
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
