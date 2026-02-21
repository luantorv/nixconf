{ config, lib, ... }:

with lib;

let
  hexToRgb = hex:
  let
    h = builtins.substring 1 6 hex;
    hexDigit = c: {
      "0"=0;"1"=1;"2"=2;"3"=3;"4"=4;
      "5"=5;"6"=6;"7"=7;"8"=8;"9"=9;
      "a"=10;"b"=11;"c"=12;"d"=13;"e"=14;"f"=15;
    }.${c};
    hexByte = s: (hexDigit (builtins.substring 0 1 s)) * 16 + (hexDigit (builtins.substring 1 1 s));
    r = hexByte (builtins.substring 0 2 h);
    g = hexByte (builtins.substring 2 2 h);
    b = hexByte (builtins.substring 4 2 h);
  in "${toString r}, ${toString g}, ${toString b}";

  palette = {
    black   = "#000000";
    white   = "#ffffff";
    grey    = "#888888";
    darkblue = "#5277c3";
    skyblue = "#7ebae4";
    green   = "#27cea9";
    pink    = "#f5a9b9";
    coral   = "#ff9c55";
    red     = "#d62900";
  };
in
{
  options.colors = mkOption {
    type = types.attrsOf types.anything;
  };

  config.colors = palette // {
    rgb = mapAttrs (_: hexToRgb) palette;
  };
}
