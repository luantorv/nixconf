#!/usr/bin/env bash
# monitor.sh — panel de monitoreo de red/puertos/SSH

# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

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

# --- Tema de colores ---
# Paleta: fondo oscuro con acentos azul/verde/amarillo/rojo por panel
#C_RESET="default"
#C_ACTIVE_BG="colour234"   # gris muy oscuro para panel activo
C_BORDER="colour240"      # gris medio para bordes
C_BORDER_ACTIVE="colour75" # azul claro para borde del panel con foco

# --- Crear sesión con ventana única ---
tmux new-session -d -s "$SESSION" -x "$(tput cols)" -y "$(tput lines)"

# --- Estética global de la sesión ---
# Barra de estado inferior
tmux set-option -t "$SESSION" status on
tmux set-option -t "$SESSION" status-position bottom
tmux set-option -t "$SESSION" status-interval 5
tmux set-option -t "$SESSION" status-style "bg=colour234,fg=colour250"

# Segmento izquierdo: nombre de sesión
tmux set-option -t "$SESSION" status-left-length 30
tmux set-option -t "$SESSION" status-left \
    "#[bg=colour75,fg=colour232,bold] #S #[bg=colour234,fg=colour75]"

# Segmento derecho: hostname + hora
tmux set-option -t "$SESSION" status-right-length 50
tmux set-option -t "$SESSION" status-right \
    "#[fg=colour244] #H #[fg=colour240]|#[fg=colour250] %H:%M  "

# Título de ventana (centro de la barra)
tmux set-option -t "$SESSION" window-status-current-format \
    "#[fg=colour250,bg=colour237] red/ssh/fw/puertos #[default]"
tmux set-option -t "$SESSION" window-status-format ""

# Bordes entre paneles
tmux set-option -t "$SESSION" pane-border-style "fg=${C_BORDER}"
tmux set-option -t "$SESSION" pane-active-border-style "fg=${C_BORDER_ACTIVE}"

# Títulos de paneles (se ven en el borde superior de cada uno)
tmux set-option -t "$SESSION" pane-border-status top
tmux set-option -t "$SESSION" pane-border-format \
    " #[bold]#{pane_title}#[nobold] "

# --- Contenido de paneles ---

# Panel 0 (superior izquierdo): puertos en escucha
tmux send-keys -t "$SESSION:0.0" \
    "printf '\033]2;Puertos\033\\\\'; watch -n 2 'echo; ss -tulpn'" Enter

# Panel 1 (superior derecho): tráfico de red con iftop
tmux split-window -t "$SESSION:0.0" -h \
    "printf '\033]2;Trafico\033\\\\'; sudo iftop -n 2>/dev/null \
       || { printf '\n  [iftop no disponible o sin permisos]\n'; read; }"

# Panel 2 (inferior izquierdo): fail2ban
tmux split-window -t "$SESSION:0.0" -v \
    "printf '\033]2;Fail2ban\033\\\\'; watch -n 5 '
     echo;
     echo \"  Jails activos:\";
     sudo fail2ban-client status 2>/dev/null | grep -E \"Jail list\" | sed \"s/^/  /\";
     echo;
     sudo fail2ban-client status sshd 2>/dev/null \
       || echo \"  [fail2ban no disponible o sshd jail no configurado]\"'"

# Panel 3 (inferior derecho): log SSH en tiempo real
tmux split-window -t "$SESSION:0.1" -v \
    "printf '\033]2;Log SSH\033\\\\'; journalctl -fu sshd --output=short-precise 2>/dev/null \
       || journalctl -fu ssh --output=short-precise"

# Equilibrar tamaños
tmux select-layout -t "$SESSION" tiled

# --- Keybindings ---
# Salir con 'q' desde cualquier panel
tmux bind-key -T root q confirm-before \
    -p "  Salir del monitor? (y/n)  " "kill-session -t $SESSION"

# Limpiar mapa tailscale al cerrar la sesión
if [[ -n "$TSMAP" ]]; then
    tmux set-hook -t "$SESSION" session-closed "run-shell 'rm -f $TSMAP'"
fi

# Foco en panel 0 al adjuntarse
tmux select-pane -t "$SESSION:0.0"

# Adjuntarse
tmux attach-session -t "$SESSION"
