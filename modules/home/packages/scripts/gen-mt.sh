#!/usr/bin/env bash

notify() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"
    local icon="${4:-}"

    if command -v notify-send >/dev/null 2>&1 && \
       { [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; }; then
        notify-send "$title" "$message" -u "$urgency" ${icon:+-i "$icon"}
    else
        echo "[$title] $message"
    fi
}

notify "Mantenimiento" "Iniciando actualización y limpieza del sistema..." "normal" "system-software-update"

if sudo nixos-rebuild switch --flake ~/nixconf#laptop; then
    sudo nix-collect-garbage --delete-older-than 7d
    nix-store --optimise
    notify "Mantenimiento" "Sistema actualizado y optimizado con éxito" "low" "checkbox-checked-symbolic"
else
    notify "Mantenimiento" "Error durante la actualización" "critical" "error"
fi
