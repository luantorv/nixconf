{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rice packages
    river-classic
    waybar
    wofi
    foot
    jetbrains-mono
    pamixer
    brightnessctl
    wlopm
    swayidle
    procps
    wl-clipboard
    cliphist
    wlr-randr
    pulsemixer
    
    # browser
    brave

    # terminal utilities
    yazi # file manager
    fzf # fuzzy find
    lazygit # tui for git
    tmux # multi

    zoxide # cd con historial inteligente
    eza # alternativa a ls
    bat #cat con highlight
    fd # faster find
    ripgrep # faster grep  
  ];
}
