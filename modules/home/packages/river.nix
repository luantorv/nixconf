# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{

  imports = [ ./desktop.nix ];
  
  home.packages = with pkgs; [
    river-classic
    waybar
    wofi
    foot
    wlopm
    swayidle
    wlr-randr
    awww
    mako
    libnotify
    thunar
    orage
    zathura
    nomacs
    
    (pkgs.writeShellApplication {
      name = "wallpaper-cycle";
      text = builtins.readFile ./scripts/wallpaper_cycle.sh;
    })
  ];
}
