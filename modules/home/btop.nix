{ config, pkgs, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "nichos-tty";
      theme_background = false;
      truecolor = true;
      force_tty = false;
      presets = "cpu:0:default,mem:0:default,net:0:default,proc:0:default";
      graph_symbol = "braille";
      update_ms = 1500;
      proc_sorting = "cpu lazy";
      proc_gradient = true;
      disks_filter = "exclude=/boot";
    };
  };

  xdg.configFile."btop/themes/nichos-tty.theme" = {
    executable = true;
    text = ''
      theme[main_bg]="${config.colors.black}"

      # Main text color
      theme[main_fg]="${config.colors.white}"

      # Title color for boxes
      theme[title]="${config.colors.white}"

      # Highlight color for keyboard shortcuts
      theme[hi_fg]="${config.colors.skyblue}"

      # Selected item background
      theme[selected_bg]="${config.colors.darkblue}"

      # Selected item foreground
      theme[selected_fg]="${config.colors.white}"

      # Color of inactive/disabled text
      theme[inactive_fg]="${config.colors.grey}"

      # Color of lines and borders
      theme[proc_misc]="${config.colors.pink}"

      # CPU graph colors (Gradient: Green -> Coral -> Red)
      theme[cpu_start]="${config.colors.green}"
      theme[cpu_mid]="${config.colors.coral}"
      theme[cpu_end]="${config.colors.red}"

      # Mem graph colors (Skyblue)
      theme[mem_start]="${config.colors.skyblue}"
      theme[mem_mid]="${config.colors.darkblue}"
      theme[mem_end]="${config.colors.darkblue}"

      # Net graph colors (Pink)
      theme[net_start]="${config.colors.pink}"
      theme[net_mid]="${config.colors.pink}"
      theme[net_end]="${config.colors.pink}"

      # Processes table (Skyblue)
      theme[proc_grid]="${config.colors.darkblue}"
      theme[proc_color_up]="${config.colors.green}"
      theme[proc_color_down]="${config.colors.red}"
  '';
  };
}