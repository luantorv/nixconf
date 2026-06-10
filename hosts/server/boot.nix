# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  boot.kernelModules = [ "ideapad_laptop" ];

  boot.kernelParams = [ 
    "intel_pstate=active" 
    "processor.max_cstate=1" 
  ];
}