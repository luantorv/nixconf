{ config, pkgs, ... }: 

let
  tra-script = pkgs.writeScriptBin "tra" ''
    #!/bin/sh
    # Obtiene el texto seleccionado actualmente
    text=$(wl-paste -p) 
    # Traduce al español (o el idioma que prefieras)
    translation=$(trans -b -t es "$text")
    # Envía la notificación a Mako
    notify-send "Traducción" "$translation"
  '';
in
{
  home.packages = [ 
    pkgs.translate-shell 
    tra-script 
  ];
}