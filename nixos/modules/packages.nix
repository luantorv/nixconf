{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	vim
  	wget
    git
	  htop
	  fastfetch
	  tree
    tuigreet
  ];
}
