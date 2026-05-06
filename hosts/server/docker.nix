{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "ollama" = {
        image = "ollama/ollama:latest";
        volumes = [ "ollama_data:/root/.ollama" ];
        ports = [ "11434:11434" ];
      };

      "open-webui" = {
        image = "ghcr.io/open-webui/open-webui:main";
        ports = [ "3000:8080" ];
        
        environmentFiles = [
          config.sops.secrets.open_webui_secret.path
        ];

        environment = {
          "OLLAMA_BASE_URL" = "http://host.docker.internal:11434";
        };

        extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];

        volumes = [ "open-webui_data:/app/backend/data" ];
        dependsOn = [ "ollama" ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3000 11434 ];
}
