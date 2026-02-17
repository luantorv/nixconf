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
        border_style = { fg = "${config.colors.blanco}"; };
      };

      status = {
        separator_open = "";
        separator_close = "";
        style = { bg = "${config.colors.nixCeleste}"; fg = "${config.colors.negro}"; };
      };

      filelist = {
        hovered = { bg = "${config.colors.nixAzul}"; fg = "${config.colors.blanco}"; bold = true; };
        selected = { bg = "${config.colors.nixCeleste}"; fg = "${config.colors.negro}"; bold = true; };
      };

      icon = {
        rules = [
          { name = "*.nix"; symbol = ""; color = "${config.colors.nixCeleste}"; }
          { name = "*.sh"; symbol = ""; color = "${config.colors.blanco}"; }
        ];
      };
    };
  };
}