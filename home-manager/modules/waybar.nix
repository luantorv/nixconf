{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "river-session.target";
    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        height = 24;

        mode = "hide";
        start_hidden = true;

        modules-left = [ 
          "custom/caffeine" 
          "clock" 
          "battery" 
          "backlight"
          "custom/media"
        ];

        modules-center = [ 
          "river/tags" 
        ];

        modules-right = [ 
          "network" 
          "bluetooth" 
          "pulseaudio" 
          "pulseaudio#microphone"
        ];

        "river/tags" = {
          num-tags = 9;
        };
   
        clock = {
          format = "{:%H:%M | %d-%m-%y}";
          timezone = "America/Argentina/Buenos_Aires";
          tooltip = false;
        };

        "network" = {
          format-wifi = "WIFI: {essid} ({signalStrength}%)";
          format-ethernet = "ETH: CONECTED";
          format-disconnected = "RED: OFF";
          tooltip-format-wifi = "{ifname} - {ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifanme} - {ipaddr}";
          on-click = "foot --app-id=float-term -e nmtui";
        };

        bluetooth = {
          interval = 10;
          format = "BT:{status}";
          format-off = "";
          format-on = "BT:ON";
          format-connected = "BT:{device_alias}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          format-connected-battery = "BT:{device_alias}:{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        pulseaudio = {
          format = "VOL:{volume}%";
          format-muted = "VOL:MUTE";
          on-click = "pamixer -t";
          on-click-right = "foot --app-id=float-term -e pulsemixer";
          scroll-step = 5;
          tooltip = false;
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "MIC:{volume}%";
          format-source-muted = "MIC:MUTE";
          on-click = "pamixer --default-source -t";
          on-click-right = "foot --app-id=float-term -e pulsemixer";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
          tooltip = false;
        };

        backlight = {
          device = "intel_backlight";
          format = "LUM: {percent}%";
          tooltip = false;
        };

        "custom/caffeine" = {
          "exec" = "if pgrep -x swayidle > /dev/null; then echo 'CAF: OFF'; else echo 'CAF: ON'; fi";
          "interval" = 2;
          "format" = "{}";
          "on-click" = "if pgrep -x swayidle > /dev/null; then pkill -x swayidle; else swayidle -w timeout 300 \"swaylock -f\" & fi";
          "tooltip" = false;
        };

        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "SPOTIFY";
            default = "PLAYING";
          };
          escape = true;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{title}}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"' -F";
        };
      }
    ];

    style = ''
      * {
        font-family: "JetBrains Mono";
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: ${config.colors.negro};
        background-color: ${config.colors.negro};
        color: ${config.colors.blanco};
        border-bottom: 2px solid ${config.colors.blanco}; /* linea divisoria simple */
      }

      #tags button {
        color: ${config.colors.gris};
        padding: 0 5px;
        border-bottom: 3px solid transparent;
      }

      #tags button.focused {
        background: linear-gradient(45deg, ${config.colors.nixAzul}, ${config.colors.nixCeleste});
        color: ${config.colors.blanco};
        border-bottom: 3px solid ${config.colors.blanco};
      }

      #tags button.visible:not(.focused) {
        background: linear-gradient(45deg, ${config.colors.conRojo}, ${config.colors.conNaranja});
        color: ${config.colors.negro};
        font-weight: bold;
        border-bottom: 3px solid ${config.colors.conRojo};
      }

      #tags button.occupied:not(.focused):not(.visible) {
        color: ${config.colors.nixCeleste};
      }

      #clock, #network, #backlight, #pulseaudio, #pulseaudio.microphone, #bluetooth, #battery, #custom-media {
        padding: 0 10px;
        border-left: 1px solid ${config.colors.blanco};
      }

      #clock {
        border-left: none;
      }

      #custom-caffeine {
        color: ${config.colors.nixCeleste};
        padding: 0 10px;
        border-right: 1px solid ${config.colors.blanco}
      }

      #bluetooth {
        color: ${config.colors.nixCeleste};
        padding: 0 10px;
      }

      #bluetooth.on {
        color: ${config.colors.conRojo};
        font-weight: bold;
      }

      #bluetooth.connected {
        color: ${config.colors.nixAzul};
        font-weight: bold;
      }

      #pulseaudio {
        color: ${config.colors.blanco};
        margin-left: 5px; 
      }

      #pulseaudio.muted:not(.microphone) {
        color: ${config.colors.conNaranja};
      }

      #pulseaudio.microphone {
        color: ${config.colors.blanco};
        margin-left: 5px;
      }

      #pulseaudio.microphone.source-muted {
        color: ${config.colors.conNaranja};
      }

      #custom-media {
        color: ${config.colors.nixCeleste};
        padding: 0 10px;
        font-style: italic;
      }
    '';
  };
}
