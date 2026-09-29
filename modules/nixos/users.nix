# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  programs.zsh.enable = true;

  users.users.${globalVars.username} = {
    isNormalUser = true;
    home = "${globalVars.homeDirectory}";
    description = "${globalVars.username}";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" "libvirtd" "kvm" ];
    packages = with pkgs; [];
  };
}
