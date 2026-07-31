# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel por defecto (fallback). Un host puede sobrescribirlo en su boot.nix.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
}
