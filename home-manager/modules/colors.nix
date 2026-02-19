{ config, lib, ... }:

with lib;

{
  options.colors = mkOption {
    type = types.attrsOf types.str;
    description = "Paleta de colores global";
  };

  config.colors = {
    black = "#000000";
    white = "#ffffff";
    grey = "#888888";
    darkblue = "#5277c3";
    skyblue = "#7ebae4";
    green = "#27cea9";
    pink = "#f5a9b9";
    coral = "#ff9c55";
    red = "#d62900";
  };
}
