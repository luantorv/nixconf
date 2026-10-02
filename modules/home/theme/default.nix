# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./colors.nix
    ./gtk.nix
    ./wallpapers.nix
  ];
}