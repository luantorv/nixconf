{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    device = "nodev";
  };
  
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelModules = [ "ideapad_laptop" ];

  boot.kernelParams = [ 
  "intel_pstate=active" 
  "processor.max_cstate=1" 
];
}
