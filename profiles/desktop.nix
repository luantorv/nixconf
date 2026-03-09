{ config, pkgs, globalVars, ... }:

{
  imports = [
    ../modules/nixos/core
    ../modules/nixos/boot/grub.nix
    
    ../modules/nixos/packages.nix
    ../modules/nixos/services.nix
    ../modules/nixos/security.nix
    ../modules/nixos/users.nix
    ../modules/nixos/variables.nix
  ];

  home-manager.users.${globalVars.username} = { pkgs, ... }: {
    imports = [
      ../modules/home/packages/desktop.nix 

      ../modules/home/desktop
      ../modules/home/editors
      ../modules/home/files
      ../modules/home/shell
      ../modules/home/terminal
      ../modules/home/theme

      ../modules/home/cliphist.nix     
      ../modules/home/sops.nix
      ../modules/home/variables.nix
    ];

    home = {
      inherit (globalVars) username homeDirectory;
      stateVersion = "25.11";
    };
  };
}