{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      BLUE="\[\033[38;2;82;119;195m\]"
      LICHT_BLUE="\[\033[38;2;1126;186;228m\]"
      RED="\[\033[01;31m\]"
      WHITE="\[\033[0m\]"
      BOLD="\[\033[1m\]"

      set_prompt() {
        local EXIT="$?"
        local SYMBOL="$WHITE\$"

        if [ $EXIT != 0 ]; then
          SYMBOL="$RED\$"
        else
          SYMBOL="$BLUE\$"
        fi

        PS1="$BOLD$BLUE\u$WHITE@$BLUE\h$WHITE:$LIGHT_BLUE\w$WHITE $SYMBOL$WHITE "
      }

      PROMPT_COMMAND=set_prompt

      if [[ $- == *i* ]]; then
        clear
        printf '\n%.0s' {1..$(tput lines)}
      fi
    '';
    shellAliases = {
      ff = "fastfetch";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      fm = "yazi";
      find = "fd";
      grep = "rg";
      cd = "zoxide";
      lg = "lazygit";
      
      gen-rb = "sudo nixos-rebuild switch";
      gen-up = "sudo cp -r ~/nixconf/nixos/* /etc/nixos/";
      gen-ls = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      hml = "home-manager generations";
      hms = "home-manager switch";
      hmu = "cp -r ~/nixconf/home-manager/* ~/.config/home-manager/";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      search_mode = "fuzzy";
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
