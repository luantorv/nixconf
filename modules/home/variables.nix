{ config, pkgs, ... }:

{
  home.sessionVariables = {
    # EDITOR = "emacs";
    TERMINAL = "foot";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  nixpkgs.config.allowUnfree = true;
}
