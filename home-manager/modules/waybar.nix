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

        mode = "dock";
        start_hidden = true;

        modules-left = [ 
          "custom/caffeine" 
          "clock" 
          "battery" 
          "custom/power_profile"
          "custom/media"
        ];

        modules-center = [ 
          "river/tags" 
        ];

        modules-right = [ 
          "backlight"
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
          format = "{icon} {text}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            Playing = "PLAYING";
            Paused = "PAUSED";
          };
          escape = true;
          exec = ''playerctl -a metadata --format '{ "text": "{{artist}} - {{title}}", "alt": "{{status}}", "class": "{{status}}" }' -F 2>/dev/null || echo '{ "text": "", "alt": "Stopped", "class": "stopped" }' '';
        };

        battery = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "BAT:{capacity}%";
          format-charning = "CHR:{capacity}%";
          format-plugged = "PWR:{capacity}%";
          format-alt = "TIME: {time}";
          tooltip = false;
        };

        "custom/power_profile" = {
          exec = "powerprofilesctl get";
          interval = 30;
          format = "PWR {}";
          on-click = "powerprofilesctl set performance";
          on-click-right = "powerprofilesctl set power-saver";
          tooltip = false;
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
        background: ${config.colors.black};
        background-color: ${config.colors.black};
        color: ${config.colors.white};
        border-bottom: 2px solid ${config.colors.white};
      }

      #tags button {
        color: ${config.colors.grey};
        padding: 0 5px;
        border-bottom: 3px solid transparent;
      }

      #tags button.focused {
        background: linear-gradient(45deg, ${config.colors.darkblue}, ${config.colors.skyblue});
        color: ${config.colors.white};
        border-bottom: 3px solid ${config.colors.white};
      }

      #tags button.visible:not(.focused) {
        background: linear-gradient(45deg, ${config.colors.pink}, ${config.colors.white});
        color: ${config.colors.black};
        font-weight: bold;
        border-bottom: 3px solid ${config.colors.red};
      }

      #tags button.occupied:not(.focused):not(.visible) {
        color: ${config.colors.pink};
      }

      #clock, #network, #backlight, #pulseaudio, #pulseaudio.microphone, #bluetooth, #battery, #custom-media, #custom-power_profile {
        padding: 0 10px;
        border-left: 1px solid ${config.colors.white};
      }

      #clock {
        border-left: none;
      }

      #custom-caffeine {
        color: ${config.colors.skyblue};
        padding: 0 10px;
        border-right: 1px solid ${config.colors.white}
      }

      #bluetooth {
        color: ${config.colors.pink};
        padding: 0 10px;
      }

      #bluetooth.on {
        color: ${config.colors.coral};
        font-weight: bold;
      }

      #bluetooth.connected {
        color: ${config.colors.green};
        font-weight: bold;
      }

      #pulseaudio {
        color: ${config.colors.white};
        margin-left: 5px; 
      }

      #pulseaudio.muted:not(.microphone) {
        color: ${config.colors.coral};
      }

      #pulseaudio.microphone {
        color: ${config.colors.white};
        margin-left: 5px;
      }

      #pulseaudio.microphone.source-muted {
        color: ${config.colors.coral};
      }

      #custom-media {
        color: ${config.colors.skyblue};
        border-left: 1px solid ${config.colors.white};
        padding: 0 10px;
        font-style: italic;
      }

      #custom-media.Paused {
        color: ${config.colors.grey};
      }

      #battery {
        color: ${config.colors.skyblue};
        padding: 0 10px;
      }

      #battery.charning, #battery.plugged {
        color: ${config.colors.skyblue};
      }

      #battery.warning:not(.charning) {
        color: ${config.colors.pink};
      }

      #battery.critical:not(.charning) {
        color: ${config.colors.red};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: ${config.colors.red};
          color: ${config.colors.white};
        }
      }
    '';
  };
}
