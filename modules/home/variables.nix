{ config, pkgs, globalVars, ... }:

{
  home = {
    sessionVariables = {
      TERMINAL = "foot";
    };

    stateVersion = "${globalVars.stateVersion}";
  };

  nixpkgs.config.allowUnfree = true;
}
