# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us"
                variant "intl"
            }
            repeat-delay 300
            repeat-rate 50
        }

        touchpad {
            tap
            natural-scroll
            accel-profile "adaptive"
        }

        focus-follows-mouse max-scroll-amount="0%"
    }

    output "eDP-1" {
        scale 1.0
    }

    layout {
        gaps 0

        center-focused-column "never"

        preset-column-widths {
            proportion 0.5
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 2
            active-color "${config.colors.white}"
            inactive-color "#333333"
        }

        border {
            off
        }
    }

    prefer-no-csd

    environment {
        DISPLAY ":0"
    }

    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "swayidle" "-w" "timeout" "300" "swaylock -f" "before-sleep" "swaylock -f"
    spawn-at-startup "udiskie"

    window-rule {
        match app-id="float-term"
        open-floating true
        default-column-width { fixed 1200; }
    }

    window-rule {
        match app-id="swappy"
        open-floating true
    }

    binds {
        // Apps
        Mod+Return { spawn "foot"; }
        Mod+E { spawn "foot" "-e" "yazi"; }
        Mod+Shift+E { spawn "thunar"; }
        Mod+C { spawn "codium"; }
        Mod+Shift+D { spawn "discord"; }
        Mod+T { spawn "foot" "--app-id=float-term" "-e" "btop"; }
        Mod+N { spawn "foot" "--app-id=float-term" "--working-directory=${globalVars.notesDir}"; }
        Mod+Shift+N { spawn "foot" "--app-id=float-term" "--working-directory=${globalVars.notesDir}" "-e" "bash" "-i" "-c" "new; exec bash"; }
        Mod+U { spawn "foot" "--app-id=float-term" "-e" "yazi" "/run/media/${globalVars.username}/"; }
        Mod+Z { spawn "foot" "--app-id=float-term" "-e" "tra"; }

        // Window management
        Mod+Q { close-window; }
        Mod+D { toggle-fullscreen; }
        Mod+F { toggle-floating; }
        Mod+O { move-window-to-output "next"; }

        // Focus (vim-style)
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }

        // Move columns/windows
        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }

        // Resize columns
        Mod+Comma { set-column-width "-5%"; }
        Mod+Period { set-column-width "+5%"; }

        // Workspaces
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Shift+1 { move-window-to-workspace 1; }
        Mod+Shift+2 { move-window-to-workspace 2; }
        Mod+Shift+3 { move-window-to-workspace 3; }
        Mod+Shift+4 { move-window-to-workspace 4; }
        Mod+Shift+5 { move-window-to-workspace 5; }
        Mod+Shift+6 { move-window-to-workspace 6; }
        Mod+Shift+7 { move-window-to-workspace 7; }
        Mod+Shift+8 { move-window-to-workspace 8; }
        Mod+Shift+9 { move-window-to-workspace 9; }

        // Session
        Mod+Alt+L { spawn "swaylock" "-f"; }
        Mod+Alt+E { quit; }
        Mod+Shift+Slash { show-hotkey-overlay; }

        // Power profiles
        Mod+F1 { spawn "sh" "-c" "powerprofilesctl set power-saver && notify-send 'Energía' 'Modo Ahorro de Batería Activo' -u low"; }
        Mod+F2 { spawn "sh" "-c" "powerprofilesctl set balanced && notify-send 'Energía' 'Modo Balanceado Activo' -u normal"; }
        Mod+F3 { spawn "sh" "-c" "powerprofilesctl set performance && notify-send 'Energía' 'Modo Performance Activo' -u critical"; }

        // Volume
        XF86AudioRaiseVolume { spawn "sh" "-c" "pamixer -i 5; notify-send Volume \"$(pamixer --get-volume)%\" -t 2000"; }
        XF86AudioLowerVolume { spawn "sh" "-c" "pamixer -d 5; notify-send Volume \"$(pamixer --get-volume)%\" -t 2000"; }
        XF86AudioMute { spawn "sh" "-c" "pamixer -t; if pamixer --get-mute | grep -q true; then notify-send Volume 'Muted' -t 2000; else notify-send Volume \"$(pamixer --get-volume)%\" -t 2000; fi"; }
        XF86AudioMicMute { spawn "sh" "-c" "pamixer --default-source -t; if pamixer --default-source --get-mute | grep -q true; then notify-send Microphone 'Muted' -t 2000; else notify-send Microphone 'Unmuted' -t 2000; fi"; }

        // Brightness
        XF86MonBrightnessUp { spawn "sh" "-c" "brightnessctl set +5% && notify-send Brightness \"$(brightnessctl | grep -o '[0-9]*%' | head -1)\" -t 2000"; }
        XF86MonBrightnessDown { spawn "sh" "-c" "brightnessctl set 5%- && notify-send Brightness \"$(brightnessctl | grep -o '[0-9]*%' | head -1)\" -t 2000"; }

        // Media
        XF86AudioPlay { spawn "sh" "-c" "playerctl play-pause; notify-send Media \"$(playerctl status)\" -t 2000"; }
        XF86AudioNext { spawn "sh" "-c" "playerctl next; notify-send Media \"$(playerctl metadata title)\" -t 2000"; }
        XF86AudioPrev { spawn "sh" "-c" "playerctl previous; notify-send Media \"$(playerctl metadata title)\" -t 2000"; }
        XF86AudioStop { spawn "sh" "-c" "playerctl stop; notify-send Media Stopped -t 2000"; }

        // Clipboard
        Mod+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

        // Screenshots
        Print { spawn "sh" "-c" "grim - | swappy -f - && notify-send 'Captura' 'Imagen guardada o copiada' -i camera"; }
        Mod+Shift+P { spawn "sh" "-c" "grim -g \"$(slurp -b 00000088 -c ffffffff -s 00000000)\" - | swappy -f - && notify-send 'Captura' 'Imagen guardada o copiada' -i camera"; }
    }
  '';
}
