# SPDX-FileCopyrightText: 2026 Luis
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, ... }:

{
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
  };

  networking.firewall.logRefusedConnections = true;

  services.fail2ban = {
    enable = true;
    jails.sshd = {
      enabled = true;
      settings = {
        maxretry = 3;
        findtime = 3600;
        bantime = 3600;
      };
    };
  };

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

  users.users.${globalVars.username}.openssh.authorizedKeys.keys = [
    # This is a public key, no worry
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6Gf9ipzbPYD6zADlf9y4ZV6I8ntNG9JIzHjBLEJybh luantorv@gmail.com"
  ];
}