{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./base.nix
    ./networking.nix
    ./nix.nix
  ];
}