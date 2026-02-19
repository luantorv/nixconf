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
        font-family: ¨JetBrains Mono¨;
        border: 2px solid ${config.colors.skyblue};
        border-radius: 12px;
      }

      #input {
        background-color: ${config.colors.black};
        color: ${config.colors.pink};
        border: none;
        border-bottom: 1px solid ${config.colors.pink};
        margin: 10px;
        padding: 5px;
      }

      #inner-box {
        margin: 10px;
      }

      #entry:selected {
        background-color: ${config.colors.pink};
        border-radius: 8px;
      }

      #text:selected {
        color: ${config.colors.black};
      }
    '';
  };
}
