# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  services.thermald.enable = true;

  hardware.graphics.enable = true;
}