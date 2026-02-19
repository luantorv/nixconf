{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
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
      cd = "z";
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
