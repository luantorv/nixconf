{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "rose-pine-moon-gtk";
      package = pkgs.rose-pine-gtk-theme;
    };

    iconTheme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-icon-theme;
    };
  };
}