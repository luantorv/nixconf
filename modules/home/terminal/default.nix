{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./btop.nix
    ./foot.nix
  ];
}