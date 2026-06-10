# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  services.thermald.enable = true;

  hardware.graphics.enable = true;
}