{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./android.nix
    ./kanshi.nix
    ./swappy.nix
    ./read_mode.nix
    ./translate.nix
  ];
}
