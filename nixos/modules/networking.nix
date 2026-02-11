{ config, pkgs, ... }:

{
  # Define hostname
  networking.hostName = "nichos";

  # Enable networking
  networking.networkmanager.enable = true;
}