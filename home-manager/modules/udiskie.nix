{ config, pkgs, ... }:

{
  services.udiskie = {
    enable = true;
    tray = "auto";
    notify = true;
    settings = {
      program_options = {
        udisks_version = 2;
      };
    };
  };
}