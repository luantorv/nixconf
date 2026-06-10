# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  system.stateVersion = "${globalVars.stateVersion}";

  console.keyMap = "us-acentos";
}