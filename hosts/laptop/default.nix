{ config, pkgs, globalVars, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ../../profiles/desktop.nix
  ];

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/b7cda332-f5a9-40ff-82e4-bb9ad18478c1";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit globalVars; };
    users.${globalVars.username} = import ../../profiles/desktop.nix;
  };

  networking.hostName = "nichos";
}