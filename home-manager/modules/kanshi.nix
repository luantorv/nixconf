{ config, pkgs, ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "wayland-session@river.target";
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable"; 
          }
          {
            criteria = "*";
            status = "enable";
            mode = "max";
            position = "1920.0";
          }
        ];
      }
    ];
  };
}