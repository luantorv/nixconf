# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{

  imports = [ ./desktop.nix ];
  
  home.packages = with pkgs; [
    niri
    swww
    swayaudioidlehold
    rose-pine-cursor
  ];
}
