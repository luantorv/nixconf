{ config, pkgs, ... }: 

{
  systemd.user.targets.river-session = {
    Unit = {
      Description = "river compositor session";
      Decumentation = [ "man:river(1)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/bin/sh

      # Propafar variables de entorno a systemd y DBus
      riverctl import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      dbus-update-activation-environment --all

      # Configuración básica
      riverctl set-repeat 50 300

      riverctl background-color 0x000000
      riverctl border-width 2
      riverctl border-color-focused 0xffffff
      riverctl border-color-unfocused 0x333333

      riverctl focus-follows-mouse  enabled
      riverctl focus-follows-cursor enabled

      riverctl keyboard-layout -variant intl us

      # Configuración de rivertile
      rivertile -view-padding 0 -outer-padding 0 &
      riverctl default-layout rivertile
      riverctl send-layout-cmd rivertile "main-ratio 0.5"

      # ===== ATAJOS =====

      # Super + Enter -> terminal
      riverctl map normal Super Return spawn foot

      # Super + Space -> wofi
      riverctl map normal Super Space spawn "pgrep wofi && pkill wofi || wofi --show drun --layer overlay"

      # Super + Q -> cerrar ventana focused
      riverctl map normal Super Q close

      # Super + D -> toggle fullscreen
      riverctl map normal Super D toggle-fullscreen

      # Super + B -> Alternar Waybar
      riverctl map normal Super B spawn "pkill -SIGUSR1 waybar"

      # Super + O -> Enviar ventana al proximo monitor
      riverctl map normal Super O send-to-output next

      # Salir de River
      riverctl map normal Super+Shift E exit 

      # Navegar entre ventanas con Super = J/K
      riverctl map normal Super J focus-view next
      riverctl map normal Super K focus-view previous

      # Mover ventanas con Super + Shift + J/K
      riverctl map normal Super+Shift J swap next
      riverctl map normal Super+Shift K swap previous

      # Redimencionar
      riverctl map normal Super Period send-layout-cmd rivertile "main-ratio -0.05"
      riverctl map normal Super Comma  send-layout-cmd rivertile "main-ratio +0.05"

      # Workpaces con Super + 1-9
      for i in 1 2 3 4 5 6 7 8 9; do
        tags=$((1 << (i - 1)))
        riverctl map normal Super $i set-focused-tags $tags
        riverctl map normal Super+Shift $i set-view-tags $tags
      done

      # Control de Volumen
      riverctl map normal None XF86AudioRaiseVolume spawn 'pamixer -i 5'
      riverctl map normal None XF86AudioLowerVolume spawn 'pamixer -d 5'
      riverctl map normal None XF86AudioMute        spawn 'pamixer -t'
      riverctl map normal None XF86AudioMicMute     spawn 'pamixer --default-source -t'

      # Control de Brillo
      riverctl map normal None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
      riverctl map normal None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'

      # Controles Multimedia
      riverctl map normal None XF86AudioPlay spawn 'playerctl play-pause'
      riverctl map normal None XF86AudioNext spawn 'playerctl next'
      riverctl map normal None XF86AudioPrev spawn 'playerctl previous'
      riverctl map normal None XF86AudioStop spawn 'playerctl stop'

      # Menu de energia
      riverctl map normal Super L spawn 'pgrep wofi && pkill wofi || (echo -e "1. Bloquear\n2. Sesion\n3. Reiniciar\n4. Apagar\n5. Portapapeles" | wofi --dmenu --header "SISTEMA:" | awk "{print \$2}" | xargs -I{} sh -c "case {} in Bloquear) swaylock -f;; Sesion) riverctl exit;; Reiniciar) reboot;; Apagar) poweroff;; Portapapeles) cliphist wipe;; esac")'

      # Portapapeles
      riverctl map normal Super V spawn "sh -c 'pgrep wofi && pkill wofi || (${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --dmenu --header \"PORTAPAPELES:\"| ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy && sleep 0.1)' "

      # Super 0 -> Enviar ventanas de la pantalla actual al otro monitor
      riverctl map normal Super 0 spawn "riverctl focus-output next && riverctl set-focused-tags $(riverctl -view-get-tags)"

      # TouchPad
      riverctl input '*Touchpad*' tap enabled
      riverctl input '*Touchpad*' natural-scroll enabled
      riverctl input '*Touchpad*' accel_profile adaptive

      # Ventanas flotantes para módulos de Waybar
      riverctl rule-add -app-id 'float-term' float
      riverctl rule-add -app-id 'float-term' dimensions 800 500
      riverctl rule-add -app-id 'float-term' border-color-focused "0x7ebae4ff"

      riverctl rule-add -app-id 'blueman' float
      riverctl rule-add -app-id 'blueman-manager' dimensions 800 500
      riverctl rule-add -app-id 'blueman-manager' position center

      # Layout
      riverctl default-layout rivertile
      rivertile -view-padding 0 -outer-padding 0 &

      # Iniciar waybar
      pkill waybar
      (sleep 2 && waybar) &
    '';
  };
}
