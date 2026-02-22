{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rice packages
    river-classic
    waybar
    wofi
    foot
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    pamixer
    brightnessctl
    wlopm
    swayidle
    procps
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
    discordo
    mpv
    unar

    # terminal utilities
    yazi
    exiftool
    ffmpegthumbnailer
    poppler-utils
    fzf
    lazygit
    tmux
    atuin
    zoxide
    eza
    bat
    fd
    ripgrep
    btop
  ];
}
