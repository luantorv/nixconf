{ config, pkgs, ... }:

# Paleta de colores

let
  nixAzul = "#5277c3";
  nixCeleste = "#7ebae4";
  conNaranja = "#f2a65a";
  conRojo = "#c1495b";
  blanco = "#ffffff";
  negro = "#000000";
  gris = "#888888";
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "luis";
  home.homeDirectory = "/home/luis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Rice packages
    river-classic
    waybar
    wofi
    foot
    jetbrains-mono
    pamixer
    brightnessctl
    wlopm
    swayidle
    procps
    wl-clipboard
    cliphist
    wlr-randr
    
    # browser
    brave

    # terminal utilities
    yazi # file manager
    fzf # fuzzy find
    lazygit # tui for git
    tmux # multi

    zoxide # cd con historial inteligente
    eza # alternativa a ls
    bat #cat con highlight
    fd # faster find
    ripgrep # faster grep  
  ];

  # Config theme for GTK
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  systemd.user.targets.river-session = {
    Unit = {
      Description = "river compositor session";
      Decumentation = [ "man:river(1)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.services.cliphist = {
    Unit = {
      Description = "Clipboard history daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "wayland-session@river.target";
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable"; 
          }
          {
            criteria = "*";
            status = "enable";
            mode = "max";
            position = "1920.0";
          }
        ];
      }
    ];
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/luis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    TERMINAL = "foot";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # Rice's Packages configs
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

      # Monitores
      riverctl output '*' mode max
      riverctl focus-output next
      riverctl set-focused-tags 2
      riverctl focus-output next

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

      # Control de Brillo
      riverctl map normal None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
      riverctl map normal None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'

      # Menu de energia
      riverctl map normal Super L spawn 'pgrep wofi && pkill wofi || (echo -e "1. Bloquear\n2. Sesion\n3. Reiniciar\n4. Apagar\n5. Portapapeles" | wofi --dmenu --header "SISTEMA:" | awk "{print \$2}" | xargs -I{} sh -c "case {} in Bloquear) swaylock -f;; Sesion) riverctl exit;; Reiniciar) reboot;; Apagar) poweroff;; Portapapeles) cliphist wipe;; esac")'

      # Portapapeles
      riverctl map normal Super V spawn "sh -c 'pgrep wofi && pkill wofi || (${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --dmenu --header \"PORTAPAPELES:\"| ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy && sleep 0.1)' "

      # Super 0 -> Enviar ventanas de la pantalla actual al otro monitor
      riverctl map normal Super 0 spawn "riverctl focus-output next && riverctl set-focused-tags $(riverctl -view-get-tags)"

      # Layout
      riverctl default-layout rivertile
      rivertile -view-padding 0 -outer-padding 0 &

      # Iniciar waybar
      pkill waybar
      (sleep 2 && waybar) &
    '';
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=12";
        pad = "10x10";
      };
      colors = {
        background = "000000";
        foreground = "ffffff";

        regular4 = "5277c3";
        regular6 = "7ebae4";
      };
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      BLUE="\[\033[38;2;82;119;195m\]"
      LICHT_BLUE="\[\033[38;2;1126;186;228m\]"
      RED="\[\033[01;31m\]"
      WHITE="\[\033[0m\]"
      BOLD="\[\033[1m\]"

      set_prompt() {
        local EXIT="$?"
        local SYMBOL="$WHITE\$"

        if [ $EXIT != 0 ]; then
          SYMBOL="$RED\$"
        else
          SYMBOL="$BLUE\$"
        fi

        PS1="$BOLD$BLUE\u$WHITE@$BLUE\h$WHITE:$LIGHT_BLUE\w$WHITE $SYMBOL$WHITE "
      }

      PROMPT_COMMAND=set_prompt

      if [[ $- == *i* ]]; then
        clear
        printf '\n%.0s' {1..$(tput lines)}
      fi
    '';
    shellAliases = {
      ff = "fastfetch";
      #ls = "eza";
      #cat = "bat";
      #ya = "yazi";
      #find = "fd";
      #grep = "rg";
      #cd = "zoxide";
      #lzg = "lazygit";

      gen-rb = "sudo nixos-rebuild switch";
      gen-ls = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      hms = "home-manager switch";
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set clipboard+=unnamedplus
    '';
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow_images = false;
      width = "80%";
      height = "30%";
      location = "bottom";
      prompt = "> ";
      term = "foot";
    };

    style = ''
      window {
        background-color: ${negro};
        color: ${blanco};
        font-family: ¨JetBrains Mono¨;
        border: 2px solid ${blanco};
        border-radius: 12px;
      }

      #input {
        background-color: ${negro};
        color: ${blanco};
        border: none;
        border-bottom: 1px solid ${gris};
        margin: 10px;
        padding: 5px;
      }

      #inner-box {
        margin: 10px;
      }

      #entry:selected {
        background-color: ${nixAzul};
        border-radius: 8px;
      }

      #text:selected {
        color: ${blanco};
      }
    '';
  };

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

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "${./nixoslogo.png}";
      scaling = "fill";
      color = "000000";
      ring-color = "5277c3";
      key-hl-color = "7ebae4";
      line-color = "00000000";
      inside-color = "00000000";
      separator-color = "00000000";
      indicator-radius = 120;
      indicator-thicknes = 15;
      show-failed-attempts = true;
    };
  };

  xdg.configFile."swaylock/config".text = ''
    image=/home/luis/.config/home-manager/nixoslogo.png
    scaling=center
    color=000000
    ring-color=5277c3
    key-hl-color=7ebae4
    line-color=00000000
    inside-color=00000000
    separator-color=00000000
    indicator-radius=120
    indicator-thicknes=15
    show-failed-attempts=true
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
	}
