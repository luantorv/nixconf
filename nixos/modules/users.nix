{ config, pkgs, ... }:

{
  users.users.luis = {
    isNormalUser = true;
    description = "luis";
    shell = pkgs.bash;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" ];
    packages = with pkgs; [];
  };
}
