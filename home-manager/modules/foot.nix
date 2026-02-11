{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=12";
        pad = "10x10";
      };
      colors = {
        background = "000000";
        foreground = "ffffff";

        regular4 = "5277c3";
        regular6 = "7ebae4";
      };
    };
  };
}