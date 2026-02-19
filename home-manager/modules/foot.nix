{ config, pkgs, ... }:

{
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

        regular1 = "d62900"; # red
        regular2 = "27cea9"; # green
        regular3 = "ff9c55"; # yellow
        regular4 = "5277c3"; # blue
        regular6 = "7ebae4"; # cian
      };
    };
  };
}
