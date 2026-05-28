{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    procps

    unar
    zip

    yazi
    exiftool
    ffmpegthumbnailer
    poppler-utils
    fzf
    lazygit
    atuin
    zoxide
    eza
    bat
    fd
    ripgrep
    btop
    tailscale
    onefetch

    benhsm-minesweeper

    (pkgs.writeShellApplication {
      name = "gen-mt";
      text = builtins.readFile ./scripts/gen-mt.sh;
    })
  ];
}