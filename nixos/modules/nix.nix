{ config, pkgs, ... }:

{
  # Activar las características experimentales
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatizar el recolector de basura y la optimización del store de Nix
  nix.gc ={
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
 
  # Automatizar las actualizaciones
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
    randomizedDelaySec = "45min";
    flags = [
      "--upgrade-action" "switch"
    ];
  };

}