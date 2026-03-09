{ config, pkgs, ... }:

let
  lockImage = ../../../assets/nixoslogo.png;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "${lockImage}";
      scaling = "fill";
      color = "000000";
      ring-color = "7eabe4";
      key-hl-color = "f5a9b9";
      line-color = "00000000";
      inside-color = "00000000";
      separator-color = "00000000";
      indicator-radius = 120;
      indicator-thicknes = 15;
      show-failed-attempts = true;
    };
  };
}
