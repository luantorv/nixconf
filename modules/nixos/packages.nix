{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  	wget
    git
	  btop
	  fastfetch
	  tree
    tuigreet

    tmux
    iftop
    lnav

    (pkgs.writeShellApplication {
      name = "monitor";
      text = builtins.readFile ./scripts/monitor.sh;
    })
  ];
}
