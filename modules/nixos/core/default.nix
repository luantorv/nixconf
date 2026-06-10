# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./base.nix
    ./networking.nix
    ./nix.nix
  ];
}