{ config, pkgs, globalVars, ... }:

{

  imports = [ ./minimal.nix ];
  
  home.packages = with pkgs; [
    xwayland
    pamixer
    brightnessctl
    wl-clipboard
    cliphist
    pulsemixer
    playerctl
    grim
    slurp
    swappy

    # browser & other
    brave
    vscodium
    xfce.thunar
    xfce.orage
    zathura
    onlyoffice-desktopeditors
    nomacs
    mpv
    steam
    discord
    spotify
    prismlauncher
    dbeaver-bin
    gnome-boxes
  ];
}
