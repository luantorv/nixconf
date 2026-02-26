{ config, pkgs, ... }:

{
  xdg.configFile."swappy/config" = {
    executable = true;
    text = ''
      [Default]
      save_dir=$HOME/Images/Screenshoots
      save_filename_format=screenshoot_%Y%m%d_%H$M%S.png
      show_panel=true
      line_size=5
      text_size=20
    '';
  };
}
