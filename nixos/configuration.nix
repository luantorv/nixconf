{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/disk.nix
      ./modules/networking.nix
      ./modules/nix.nix
      ./modules/packages.nix
      ./modules/security.nix
      ./modules/services.nix
      ./modules/users.nix
      ./modules/variables.nix
    ];

  system.stateVersion = "25.11";
}
