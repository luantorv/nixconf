# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        pad = "10x10";
      };
      colors-dark = {
        background = "141311";
        foreground = "c7bfba";

        regular0 = "141311"; # black
        regular1 = "e75f6f"; # red
        regular2 = "295e3c"; # green
        regular3 = "9f842e"; # sand
        regular4 = "2ea0c7"; # darkblue
        regular6 = "17a696"; # lightblue
        regular7 = "c7bfba"; # white

        bright0 = "8a8583"; # grey
      };
    };
  };
}
