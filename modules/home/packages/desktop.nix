# SPDX-FileCopyrightText: 2026 Luis Reis Viera
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
    onlyoffice-desktopeditors
    mpv
    discord
    prismlauncher
    dbeaver-bin
    gnome-boxes
    cinny-desktop
    whatsapp-electron
    clickup
    pika-backup

    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.kcalc
    kdePackages.kamera
    drawy
    reaper

    claude-code
    codex

    (pkgs.writeShellApplication {
      name = "cpenv";
      text = builtins.readFile ./scripts/cp-template.sh;
    })
  ];
}
