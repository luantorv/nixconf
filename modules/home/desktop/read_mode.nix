{ config, pkgs, ... }:

let
  modo-lectura = pkgs.writeScriptBin "modo-lectura" ''
    #!/bin/sh
    if pgrep -x "wlsunset" > /dev/null
    then
        pkill wlsunset
        notify-send "Modo Lectura" "Desactivado" -h string:x-canonical-private-synchronous:modo-lectura
    else
        # 3000 es la temperatura cálida, puedes subirlo a 4000 si es muy naranja
        wlsunset -T 3000 & 
        notify-send "Modo Lectura" "Activado (3000K)" -h string:x-canonical-private-synchronous:modo-lectura
    fi
  '';
in
{
  home.packages = [ modo-lectura pkgs.wlsunset ];
}