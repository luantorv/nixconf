#!/usr/bin/env bash
# monitor.sh — panel de monitoreo de red/puertos/SSH

SESSION="monitor"

# No levantar una segunda sesión si ya existe
if tmux has-session -t "$SESSION" 2>/dev/null; then
    tmux attach-session -t "$SESSION"
    exit 0
fi

# --- Helpers para nombres de nodos via Tailscale ---
# Genera un archivo temporal con el mapeo IP->nombre, si tailscale está disponible
TSMAP=""
if command -v tailscale &>/dev/null; then
    TSMAP=$(mktemp /tmp/monitor_tsmap.XXXXXX)
    tailscale status --json 2>/dev/null \
        | grep -oP '"TailAddr":\s*"\K[^"]+|"HostName":\s*"\K[^"]+' \
        | paste - - \
        > "$TSMAP"
fi

# Wrapper para iftop: sustituye IPs tailscale por nombre de nodo si hay mapeo
iftop_cmd() {
    if [[ -n "$TSMAP" && -s "$TSMAP" ]]; then
        # iftop no soporta resolución custom, usamos el flag -n y dejamos
        # que el usuario vea IPs; el panel de tailscale (ss) complementa.
        sudo iftop -n 2>/dev/null
    else
        sudo iftop -n 2>/dev/null
    fi
}

# --- Layout tmux ---
# Crea sesión en background
tmux new-session -d -s "$SESSION" -x "$(tput cols)" -y "$(tput lines)"

# Panel superior izquierdo (0): ss — puertos abiertos
tmux send-keys -t "$SESSION:0.0" \
    "watch -n 2 'echo \"=== Puertos en escucha ===\"; ss -tulpn'" Enter

# Dividir horizontalmente: panel superior derecho (1): iftop
tmux split-window -t "$SESSION:0.0" -h
tmux send-keys -t "$SESSION:0.1" "$(declare -f iftop_cmd); iftop_cmd" Enter

# Dividir el panel izquierdo verticalmente: panel inferior izquierdo (2): fail2ban
tmux split-window -t "$SESSION:0.0" -v
tmux send-keys -t "$SESSION:0.2" \
    "watch -n 5 'echo \"=== Fail2ban — jails activos ===\"; sudo fail2ban-client status 2>/dev/null | grep -E \"Jail list\" && echo && sudo fail2ban-client status sshd 2>/dev/null || echo \"[fail2ban no disponible o sshd jail no configurado]\"'" Enter

# Dividir el panel derecho verticalmente: panel inferior derecho (3): journalctl SSH
tmux split-window -t "$SESSION:0.1" -v
tmux send-keys -t "$SESSION:0.3" \
    "journalctl -fu sshd --output=short-precise 2>/dev/null || journalctl -fu ssh --output=short-precise" Enter

# Equilibrar tamaños
tmux select-layout -t "$SESSION" tiled

# Bind para salir con 'q' desde cualquier panel (mata la sesión entera)
tmux bind-key -T root q confirm-before -p "Salir del monitor? (y/n)" "kill-session -t $SESSION"

# Limpiar mapa tailscale al cerrar la sesión
if [[ -n "$TSMAP" ]]; then
    tmux set-hook -t "$SESSION" session-closed "run-shell 'rm -f $TSMAP'"
fi

# Adjuntarse
tmux attach-session -t "$SESSION"
