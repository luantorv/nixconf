{ config, pkgs, globalVars, ... }:

{

  imports = [ ./desktop.nix ];
  
  home.packages = with pkgs; [
    niri
    swww
    swayaudioidlehold
    rose-pine-cursor
  ];
}
