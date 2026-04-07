{ config, pkgs, ... }:

let
  modo-lectura = pkgs.writeScriptBin "modo-lectura" ''
    #!/bin/sh
    if pgrep -x "wlsunset" > /dev/null
    then
        pkill wlsunset
        notify-send "Modo Lectura" "Desactivado" -h string:x-canonical-private-synchronous:modo-lectura
    else
        wlsunset -t 3000 -T 3000 &
        notify-send "Modo Lectura" "Activado (3000K)" -h string:x-canonical-private-synchronous:modo-lectura
    fi
  '';
in
{
  home.packages = [ modo-lectura pkgs.wlsunset ];
}