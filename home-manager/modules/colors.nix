{ config, lib, ... }:

with lib;

{
  options.colors = mkOption {
    type = types.attrsOf types.str;
    description = "Paleta de colores global";
  };

  config.colors = {
    negro = "#000000";
    blanco = "#ffffff";
    gris = "#888888";
    nixAzul = "#5277c3";
    nixCeleste = "#7ebae4";
    conNaranja = "#f2a65a";
    conRojo = "#c1495b";
  };
}
