{ config, pkgs, ... }:

{
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  services.thermald.enable = true;

  hardware.graphics.enable = true;
}