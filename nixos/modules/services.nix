{ config, pkgs, ... }:

{
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Config portal xdg
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  services.dbus.enable = true;

  programs.dconf.enable = true;
  programs.ssh.startAgent = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}