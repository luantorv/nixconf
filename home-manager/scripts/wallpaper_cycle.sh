#!/usr/bin/env bash
PIDFILE="$HOME/.cache/wallpaper_cycle.pid"

if [ -f "$PIDFILE" ]; then
	old_pid=$(cat "$PIDFILE")
	if kill -0 "$old_pid" 2>/dev/null; then
		kill "$old_pid"
	fi
fi

echo $$ > "$PIDFILE"

DIR=$HOME/Images/Wallpapers

# Elegir la imagen inicial con Wofi
START_IMG=$(ls $DIR | wofi --dmenu --prompt "Empezar presentación con...")

if [ -n "$START_IMG" ]; then
	swww img "$DIR/$START_IMG" --transition-type outer

	while true; do
		sleep 15m
		NEXT_IMG=$(ls $DIR | shuf -n 1)
		swww img "$DIR/$NEXT_IMG" --transition-type random
		notify-send "Wallpaper" "Cambiado a: $NEXT_IMG" -t 2000
	done
fi
