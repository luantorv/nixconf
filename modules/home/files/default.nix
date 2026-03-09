{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./udiskie.nix
    ./yazi.nix
  ];
}