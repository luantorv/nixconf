{ config, pkgs, globalVars, ... }:

{
  home.activation.copyWallpapers = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${globalVars.wallpapersDir}" ] || [ -z "$(ls -A ${globalVars.wallpapersDir})" ]; then
      mkdir -p "${globalVars.wallpapersDir}"
      cp ${../assets/wallpapers}/* "${globalVars.wallpapersDir}/"
    fi
  '';
}