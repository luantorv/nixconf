{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./foot.nix
    ./gtk.nix
    ./mako.nix
    ./river.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
}
