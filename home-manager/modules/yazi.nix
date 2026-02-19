{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };

      opener = {
        edit = [
          { run = "nvim \"$@\""; block = true; }
        ];
        play = [
          { run = "mpv \"$@\""; orphan = true; }
        ];
      };
    };

    theme = {
      manager = {
        border_symbol = "|";
        border_style = { fg = "${config.colors.white}"; };
      };

      status = {
        separator_open = "[";
        separator_close = "]";
        style = { bg = "${config.colors.darkblue}"; fg = "${config.colors.white}"; };
      };

      filelist = {
        hovered = { bg = "${config.colors.darkblue}"; fg = "${config.colors.white}"; bold = true; };
        selected = { bg = "${config.colors.skyblue}"; fg = "${config.colors.black}"; bold = true; };
      };

      icon = {
        rules = [
          { name = "*.nix"; symbol = "nix"; color = "${config.colors.skyblue}"; }
          { name = "*.sh"; symbol = "sh"; color = "${config.colors.green}"; }
        ];
      };
    };
  };
}
