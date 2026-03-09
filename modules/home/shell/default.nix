{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./bash.nix
    ./starship.nix
  ];
}