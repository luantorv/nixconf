# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./kanshi.nix
    ./swappy.nix
    ./read_mode.nix
    ./translate.nix
  ];
}
