# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker
  ];

  users.users.${globalVars.username}.extraGroups = [ "docker" ];
}
