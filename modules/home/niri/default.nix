{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./foot.nix
    ./gtk.nix
    ./mako.nix
    ./rofi.nix
    ./swayidle.nix
    ./waybar.nix
  ];
}
