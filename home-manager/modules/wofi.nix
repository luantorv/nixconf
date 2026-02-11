{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = false;
      width = "80%";
      height = "30%";
      location = "bottom";
      prompt = "> ";
      term = "foot";
    };

    style = ''
      window {
        background-color: ${negro};
        color: ${blanco};
        font-family: ¨JetBrains Mono¨;
        border: 2px solid ${blanco};
        border-radius: 12px;
      }

      #input {
        background-color: ${negro};
        color: ${blanco};
        border: none;
        border-bottom: 1px solid ${gris};
        margin: 10px;
        padding: 5px;
      }

      #inner-box {
        margin: 10px;
      }

      #entry:selected {
        background-color: ${nixAzul};
        border-radius: 8px;
      }

      #text:selected {
        color: ${blanco};
      }
    '';
  };
}