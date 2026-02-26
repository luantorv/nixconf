{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    extraConfig = ''
      set clipboard+=unnamedplus
    '';
  };
}