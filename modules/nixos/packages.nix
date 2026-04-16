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
  ];
}
