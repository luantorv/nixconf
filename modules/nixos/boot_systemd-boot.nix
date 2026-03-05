{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enabled = true;
  
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
