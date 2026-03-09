{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./kanshi.nix
    ./mako.nix
    ./river.nix
    ./swappy.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
}