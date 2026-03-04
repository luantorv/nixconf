{ config, pkgs, ... }:

{
  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  services.thermald.enable = true;

  hardware.opengl.enable = true;
}