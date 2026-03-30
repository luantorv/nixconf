{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ../../profiles/minimal.nix
    ../../modules/nixos/server.nix
    ./nixbox.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit globalVars sops-nix; };
    sharedModules = [ sops-nix.homeManagerModules.sops ];
  };

  networking.hostName = "server";
}
