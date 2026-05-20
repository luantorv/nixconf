{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    backgroundColor = "#232136";
    textColor = "#e0def4";
    borderColor = "#ea9a97";
    progressColor = "#3e8fb0";
  };
}