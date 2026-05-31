{ config, pkgs, globalVars, sops-nix, nixpkgs-old, ... }:

{
  imports = [
    ./nvim.nix
  ];
}
