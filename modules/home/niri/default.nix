# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  imports = [
    ./noctalia.nix
    ./foot.nix
    ./gtk.nix
    ./swaylock.nix
    ./niri.nix
  ];
}
