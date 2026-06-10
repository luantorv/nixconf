# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

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