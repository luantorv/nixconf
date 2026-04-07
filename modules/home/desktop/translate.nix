{ config, pkgs, ... }: 

let
  tra-script = pkgs.writeScriptBin "tra" ''
    #!/bin/sh
    # Obtener el texto seleccionado
    text=$(wl-paste -p)

    # Limpiar la pantalla
    clear
    echo -e "\e[34m--- Traducción ---\e[0m\n" # En azul (darkblue)

    ${pkgs.translate-shell}/bin/trans -t es "$text"

    echo -e "\n\e[38;5;8mPresiona cualquier tecla para salir...\e[0m"
    read -n 1
  '';
in
{
  home.packages = [ 
    pkgs.translate-shell 
    tra-script 
  ];
}