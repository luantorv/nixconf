{ config, pkgs, globalVars, ... }:

{

  imports = [ ./minimal.nix ];
  
  home.packages = with pkgs; [
    # Rice packages
    river-classic
    waybar
    wofi
    foot
    pamixer
    brightnessctl
    wlopm
    swayidle
    wl-clipboard
    cliphist
    wlr-randr
    pulsemixer
    playerctl
    grim
    slurp
    swappy
    swww
    mako
    libnotify

    # browser & other
    brave
    vscodium
    xfce.thunar
    zathura
    onlyoffice-desktopeditors
    nomacs
    mpv
    steam
    discord
    spotify
    prismlauncher

    
    (pkgs.writeShellApplication {
      name = "wallpaper-cycle";
      text = builtins.readFile ./scripts/wallpaper_cycle.sh;
    })
  ];
}
