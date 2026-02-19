{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  
    settings = {
      format = ''
      [$username]($style) [$directory]($style) $git_branch $nix_shell
      $character '';
    
      username = {
        style_user = "bold ${config.colors.skyblue}";
        show_always = true;
      };

      directory = {
        style = "bold ${config.colors.pink}";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      character = {
        success_symbol = "[➜](${config.colors.white})";
        error_symbol = "[➜](${config.colors.red})";
      };

      git_branch = {
        symbol = " ";
        style = "bold ${config.colors.pink}";
      };

      nix_shell = {
        symbol = " ";
        style = "bold ${config.colors.darkblue}";
        format = "via [$symbol$state]($style) ";
      };
    };
  };
}