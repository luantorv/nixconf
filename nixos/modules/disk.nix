{ config, pkgs, ... }:

{
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/b7cda332-f5a9-40ff-82e4-bb9ad18478c1";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };
}
