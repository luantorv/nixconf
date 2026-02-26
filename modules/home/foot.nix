{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        pad = "10x10";
      };
      colors = {
        background = "000000";
        foreground = "ffffff";

        regular0 = "000000"; # black
        regular1 = "d62900"; # red
        regular2 = "27cea9"; # green
        regular3 = "ff9c55"; # coral
        regular4 = "5277c3"; # darkblue
        regular6 = "7ebae4"; # skyblue
        regular7 = "ffffff"; # white

        bright0 = "888888"; # grey
      };
    };
  };
}
