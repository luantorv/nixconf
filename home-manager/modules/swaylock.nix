{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "${home/luis/.config/home-manager/nixoslogo.png}";
      scaling = "fill";
      color = "000000";
      ring-color = "5277c3";
      key-hl-color = "7ebae4";
      line-color = "00000000";
      inside-color = "00000000";
      separator-color = "00000000";
      indicator-radius = 120;
      indicator-thicknes = 15;
      show-failed-attempts = true;
    };
  };

  xdg.configFile."swaylock/config".text = ''
    image=/home/luis/.config/home-manager/nixoslogo.png
    scaling=center
    color=000000
    ring-color=5277c3
    key-hl-color=7ebae4
    line-color=00000000
    inside-color=00000000
    separator-color=00000000
    indicator-radius=120
    indicator-thicknes=15
    show-failed-attempts=true
  '';
}