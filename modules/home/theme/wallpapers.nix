# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  home.activation.copyWallpapers = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${globalVars.wallpaperDir}" ] || [ -z "$(ls -A ${globalVars.wallpaperDir})" ]; then
      mkdir -p "${globalVars.wallpaperDir}"
      cp ${../../../assets/wallpapers}/* "${globalVars.wallpaperDir}/"
    fi
  '';
}