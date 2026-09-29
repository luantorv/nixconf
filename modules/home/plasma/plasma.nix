# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;
  };

  home.file.".local/share/color-schemes/Verdigris.colors" = {
    source = ./Verdigris.colors;
  };
}
