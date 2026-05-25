{ pkgs, config, globalVars, ... }:

{
  programs.adb.enable = true;
  services.gvfs.enable = true;

  users.users."${globalVars.username}".extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    libmtp
    mtpfs
    scrcpy
  ];
}