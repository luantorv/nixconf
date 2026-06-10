# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  # Allow swaylock for verification
  security.pam.services.swaylock = {};
}