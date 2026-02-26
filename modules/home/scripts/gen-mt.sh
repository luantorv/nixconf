#!/bin/bash

# Enviar notificación de inicio
notify-send "Mantenimiento" "Iniciando actualización y limpieza del sistema..." -i system-software-update

# 1. Actualizar el sistema (si usas Flakes, añade --flake .#default)
if sudo nixos-rebuild switch; then
    # 2. Limpiar generaciones viejas de más de 7 días
    sudo nix-collect-garbage --delete-older-than 7d
    
    # 3. Optimizar el almacenamiento (hardlinks para archivos duplicados)
    nix-store --optimise
    
    notify-send "Mantenimiento" "Sistema actualizado y optimizado con éxito" -u low -i checkbox-checked-symbolic
else
    notify-send "Mantenimiento" "Error durante la actualización" -u critical -i error
fi