{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./docker.nix
    ../../modules/home/sops.nix
    ../../profiles/minimal.nix
    ../../modules/nixos/server.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit globalVars sops-nix; };
    sharedModules = [ sops-nix.homeManagerModules.sops ];
  };

  networking.hostName = "server";
}
