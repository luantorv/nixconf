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
        background-color: ${config.colors.negro};
        color: ${config.colors.blanco};
        font-family: ¨JetBrains Mono¨;
        border: 2px solid ${config.colors.blanco};
        border-radius: 12px;
      }

      #input {
        background-color: ${config.colors.negro};
        color: ${config.colors.blanco};
        border: none;
        border-bottom: 1px solid ${config.colors.gris};
        margin: 10px;
        padding: 5px;
      }

      #inner-box {
        margin: 10px;
      }

      #entry:selected {
        background-color: ${config.colors.nixAzul};
        border-radius: 8px;
      }

      #text:selected {
        color: ${config.colors.blanco};
      }
    '';
  };
}
