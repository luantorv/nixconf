{ config, pkgs, globalVars, ... }:

{
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
  };

  networking.firewall.logRefusedConnections = true;

  services.avahi.enable = false;
  services.printing.enable = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.tailscale.enable = true;

  users.users.luis.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6Gf9ipzbPYD6zADlf9y4ZV6I8ntNG9JIzHjBLEJybh luantorv@gmail.com"
  ];
}