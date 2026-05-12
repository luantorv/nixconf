{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./kanshi.nix
    ./swappy.nix
    ./read_mode.nix
    ./translate.nix
  ];
}
