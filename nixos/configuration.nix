{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/networking.nix
      ./modules/packages.nix
      ./modules/security.nix
      ./modules/services.nix
      ./modules/users.nix
      ./modules/disk.nix
    ];

  # Esto es oara activar las características experimentales
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Automatizar el recolector de basura y la optimización del store de Nix
  nix.gc ={
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  system.stateVersion = "25.11";
}
