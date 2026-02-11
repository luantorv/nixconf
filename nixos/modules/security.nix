{ config, pkgs, ... }:

{
  # Allow swaylock fot verification
  security.pam.services.swaylock = {};
}