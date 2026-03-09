{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./colors.nix
    ./gtk.nix
    ./wallpapers.nix
  ];
}