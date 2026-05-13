{ config, pkgs, globalVars, ... }:

{

  imports = [ ./desktop.nix ];
  
  home.packages = with pkgs; [
    river-classic
    waybar
    wofi
    foot
    wlopm
    swayidle
    wlr-randr
    swww
    mako
    libnotify
    
    (pkgs.writeShellApplication {
      name = "wallpaper-cycle";
      text = builtins.readFile ./scripts/wallpaper_cycle.sh;
    })
  ];
}
