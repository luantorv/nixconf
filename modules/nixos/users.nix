{ config, pkgs, globalVars, ... }:

{
  users.users.${globalVars.username} = {
    isNormalUser = true;
    home = "${globalVars.homeDirectory}";
    description = "${globalVars.username}";
    shell = pkgs.bash;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" "libvirtd" "kvm" ];
    packages = with pkgs; [];
  };
}
