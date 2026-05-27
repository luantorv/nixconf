#!/usr/bin/env bash
# monitor.sh — panel de monitoreo de red/puertos/SSH

SESSION="monitor"

# No levantar una segunda sesión si ya existe
if tmux has-session -t "$SESSION" 2>/dev/null; then
    tmux attach-session -t "$SESSION"
    exit 0
fi

# --- Helpers para nombres de nodos via Tailscale ---
TSMAP=""
if command -v tailscale &>/dev/null; then
    TSMAP=$(mktemp /tmp/monitor_tsmap.XXXXXX)
    tailscale status --json 2>/dev/null \
        | grep -oP '"TailAddr":\s*"\K[^"]+|"HostName":\s*"\K[^"]+' \
        | paste - - \
        > "$TSMAP"
fi

# --- Layout tmux ---
# Crear sesión con ventana única, panel 0
tmux new-session -d -s "$SESSION" -x "$(tput cols)" -y "$(tput lines)"

# Panel 0 (superior izquierdo): ss — puertos abiertos
tmux send-keys -t "$SESSION:0.0" \
    "watch -n 2 'echo \"=== Puertos en escucha ===\"; ss -tulpn'" Enter

# Panel 1 (superior derecho): split horizontal desde panel 0
tmux split-window -t "$SESSION:0.0" -h \
    "sudo iftop -n 2>/dev/null || { echo '[iftop no disponible o sin permisos]'; read; }"

# Panel 2 (inferior izquierdo): split vertical desde panel 0
tmux split-window -t "$SESSION:0.0" -v \
    "watch -n 5 'echo \"=== Fail2ban — jails activos ===\";
     sudo fail2ban-client status 2>/dev/null | grep -E \"Jail list\";
     echo;
     sudo fail2ban-client status sshd 2>/dev/null \
       || echo \"[fail2ban no disponible o sshd jail no configurado]\"'"

# Panel 3 (inferior derecho): split vertical desde panel 1
tmux split-window -t "$SESSION:0.1" -v \
    "journalctl -fu sshd --output=short-precise 2>/dev/null \
       || journalctl -fu ssh --output=short-precise"

# Equilibrar tamaños
tmux select-layout -t "$SESSION" tiled

# Bind para salir con 'q' desde cualquier panel (mata la sesión entera)
tmux bind-key -T root q confirm-before -p "Salir del monitor? (y/n)" "kill-session -t $SESSION"

# Limpiar mapa tailscale al cerrar la sesión
if [[ -n "$TSMAP" ]]; then
    tmux set-hook -t "$SESSION" session-closed "run-shell 'rm -f $TSMAP'"
fi

# Foco en panel 0 al adjuntarse
tmux select-pane -t "$SESSION:0.0"

# Adjuntarse
tmux attach-session -t "$SESSION"
