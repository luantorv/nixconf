{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./mako.nix
    ./river.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
}
