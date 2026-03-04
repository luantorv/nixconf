{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  networking.firewall.logRefusedConnections = true;

  services.avahi.enable = false;
  services.printing.enable = false;
}