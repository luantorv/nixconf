# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  # Kernel CachyOS optimizado para x86_64-v3 (AVX2).
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

  boot.kernelModules = [ "ideapad_laptop" ];

  boot.kernelParams = [ 
    "intel_pstate=active" 
    "processor.max_cstate=1" 
  ];

  # Add zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # Habilitar hibernación usando la partición swap
  boot.resumeDevice = "/dev/disk/by-uuid/988d9290-2de4-4f9f-a73a-85a34af44f86";
}
