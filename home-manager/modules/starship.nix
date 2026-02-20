{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  
    settings = {
      format = ''
      [](${config.colors.skyblue})[ $username ](bold black bg:${config.colors.skyblue})[](${config.colors.skyblue}) [](${config.colors.pink})[ $directory ](bold black bg:${config.colors.pink})[](${config.colors.pink}) $git_branch$nix_shell
      $character '';
    
      username = {
        style_user = "bold ${config.colors.black} bg:${config.colors.skyblue}";
        format = "[$user]($style)";
        show_always = true;
      };

      directory = {
        style = "bold ${config.colors.black} bg:${config.colors.pink}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      character = {
        success_symbol = "[➜](${config.colors.darkblue})";
        error_symbol = "[➜](${config.colors.red})";
      };

      git_branch = {
        symbol = " ";
        style = "bold ${config.colors.black} bg:${config.colors.white}";
        format = "[](${config.colors.white})[ $symbol$branch ]($style)[](${config.colors.white})";
      };

      nix_shell = {
        symbol = " ";
        style = "bold ${config.colors.black} bg:${config.colors.white}";
        format = "[](${config.colors.white})[ $symbol$state ]($style)[](${config.colors.white})";
      };
    };
  };
}