# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

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
