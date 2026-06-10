# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    backgroundColor = "#232136";
    textColor = "#e0def4";
    borderColor = "#ea9a97";
    progressColor = "#3e8fb0";
  };
}