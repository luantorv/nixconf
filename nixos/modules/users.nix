{ config, pkgs, ... }:

{
  users.users.luis = {
    isNormalUser = true;
    description = "luis";
    shell = pkgs.bash;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
  };
}