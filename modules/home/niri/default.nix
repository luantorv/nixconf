# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

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
