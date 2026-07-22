# SPDX-FileCopyrightText: 2026 Luis Ries Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

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

  services.udisks2.enable = true;

  services.irqbalance.enable = true;

  services.tailscale.enable = true;
}
