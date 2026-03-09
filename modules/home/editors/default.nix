{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./nvim.nix
    ./vim.nix
  ];
}