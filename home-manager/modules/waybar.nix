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
        heigh = 24;

        mode = "hide";
        start_hidden = true;

        modules-left = [ 
          "custom/caffeine" 
          "clock" 
          "battery" 
          "backlight"
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

        network = {
          format-wifi = "WIFI: {essid} {signalBm}dBm";
          format-ethernet = "ETH:CONECTED";
          format-disconnected = "RED:OFF";
          tooltip = false;
        };

        "bluetooth" = {
          "interval" = 10;
          "format" = "BT:{status}";
          "format-off" = "";
          "format-on" = "BT:ON";
          "format-connected" = "BT:{device_alias}";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "format-connected-battery" = "BT:{device_alias}:{device_battery_percentage}%";
          "on-click" = "blueman-manager";
        };

        pulseaudio = {
          format = "VOL:{volume}%";
          format-muted = "VOL:MUTE";
          on-click = "pamixer -t";
          scroll-step = 5;
          tooltip = false;
        };

        "pulseaduio#microphone" = {
          "format" = "{format_source}";
          "format-source" = "MIC:{volume}%";
          "format-source-muted" = "MIC:MUTE";
          "on-click" = "pamixer --default-source -t";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "on-scroll-down" = "pamixer --default-source -i 5";
          "scroll-step" = 5;
          "tooltip" = false;
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
        background: ${negro};
        background-color: ${negro};
        color: ${blanco};
        border-bottom: 2px solid ${blanco}; /* linea divisoria simple */
      }

      #tags button {
        color: ${gris};
        padding: 0 5px;
        border-bottom: 3px solid transparent;
      }

      #tags button.focused {
        background: linear-gradient(45deg, ${nixAzul}, ${nixCeleste});
        color: ${blanco};
        border-bottom: 3px solid ${blanco};
      }

      #tags button.visible:not(.focused) {
        background: linear-gradient(45deg, ${conRojo}, ${conNaranja});
        color: ${negro};
        font-weight: bold;
        border-bottom: 3px solid ${conRojo};
      }

      #tags button.occupied:not(.focused):not(.visible) {
        color: ${nixCeleste};
      }

      #clock, #network, #backlight, #pulseaudio, #pulseaudio.microphone, #bluetooth {
        padding: 0 10px;
        border-left: 1px solid ${blanco};
      }

      #clock {
        border-left: none;
      }

      #custom-caffeine {
        color: ${nixCeleste};
        padding: 0 10px;
        border-right: 1px solid ${blanco}
      }

      #bluetooth {
        color: ${nixCeleste};
        padding: 0 10px;
      }

      #bluetooth.on {
        color: ${conRojo};
        font-weight: bold;
      }

      #bluetooth.connected {
        color: ${nixAzul};
        font-weight: bold;
      }

      #pulseaudio.microphone {
        color: ${blanco};
        padding: 0 10px;
        margin-left: 5px;
      }

      #pulseaudio.microphone.muted {
        color: ${conRojo};
      }
    '';
  };
}