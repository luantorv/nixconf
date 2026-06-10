# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
