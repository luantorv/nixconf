# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, pkgs-new, globalVars, ... }:

{

  imports = [ ./minimal.nix ];

  programs.firefox = {
    enable = true;
    languagePacks = [ "es-AR" "en-US" ];
  };
  
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

    chromium
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
