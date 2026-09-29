# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = false;
      width = "80%";
      height = "30%";
      location = "center";
      prompt = "> ";
      term = "foot";
    };

    style = ''
      window {
        background-color: ${config.colors.black};
        color: ${config.colors.white};
        font-family: ¨JetBrains Mono Nerd Font¨;
        border: 2px solid ${config.colors.lightblue};
        border-radius: 12px;
      }

      #input {
        background-color: ${config.colors.black};
        color: ${config.colors.grey};
        border: none;
        border-bottom: 1px solid ${config.colors.lavanda};
        margin: 10px;
        padding: 5px;
      }

      #inner-box {
        margin: 10px;
      }

      #entry:selected {
        background-color: ${config.colors.lavanda};
        border-radius: 8px;
      }

      #text:selected {
        color: ${config.colors.black};
      }
    '';
  };
}
