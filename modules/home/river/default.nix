# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./foot.nix
    ./mako.nix
    ./river.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
}
