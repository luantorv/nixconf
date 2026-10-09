# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    #enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      format = "$username$hostname $directory $git_branch $nix_shell\n$character";

      username = {
        ssh_only = true;
        style_user = "${config.colors.sand}";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = true;
        style = "${config.colors.sand}";
        format = "[:$hostname]($style)";
      };

      directory = {
        style = "${config.colors.grey}";
        format = "[$path]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "git:";
        style = "${config.colors.lavanda}";
        format = "[$symbol$branch]($style)";
      };

      nix_shell = {
        symbol = "nix:";
        style = "${config.colors.darkblue}";
        format = "[$symbol$state]($style)";
      };

      character = {
        success_symbol = "[>](${config.colors.green})";
        error_symbol = "[>](${config.colors.red})";
      };
    };
  };
}