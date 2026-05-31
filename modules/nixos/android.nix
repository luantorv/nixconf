{ pkgs, config, globalVars, ... }:

{
  services.gvfs.enable = true;

  users.users."${globalVars.username}".extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    android-tools
    libmtp
    mtpfs
    scrcpy
  ];
}