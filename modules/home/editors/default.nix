{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./nvim.nix
  ];
}
