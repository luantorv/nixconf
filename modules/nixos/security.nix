{ config, pkgs, ... }:

{
  # Allow swaylock for verification
  security.pam.services.swaylock = {};
}