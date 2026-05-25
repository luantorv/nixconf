{ config, pkgs, globalVars, ... }:

{
  system.stateVersion = "${globalVars.stateVersion}";

  console.keyMap = "us-acentos";
}