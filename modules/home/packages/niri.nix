# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  imports = [ ./desktop.nix ];

  home.packages = with pkgs; [
    xwayland-satellite
    swaylock-effects
    swayidle
    foot
    wlopm
    libnotify
    fuzzel
  ];
}
