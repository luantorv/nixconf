{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    procps

    unar

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
    tailscale

    (pkgs.writeShellApplication {
      name = "gen-mt";
      text = builtins.readFile ./scripts/gen-mt.sh;
    })
  ];
}