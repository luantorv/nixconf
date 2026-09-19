# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };

      efi.canTouchEfiVariables = true;
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

    plymouth = {
      enable = true;
      theme = "bgrt";
      # theme = "spinner";
    };

    # Silent boot
    consoleLogLevel = 3;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
