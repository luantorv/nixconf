# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{

  imports = [ ./minimal.nix ];
  
  home.packages = with pkgs; [
    xwayland
    pamixer
    brightnessctl
    wl-clipboard
    cliphist
    pulsemixer
    playerctl
    grim
    slurp
    swappy

    # browser & other
    brave
    vscodium
    thunar
    orage
    zathura
    onlyoffice-desktopeditors
    nomacs
    mpv
    steam
    discord
    prismlauncher
    dbeaver-bin
    gnome-boxes
    cinny-desktop
  ];
}
