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
        
        # Cargamos el secreto desde el path que genera sops-nix
        environmentFiles = [
          # sops-nix por defecto coloca los secretos en /run/secrets/
          config.sops.secrets.open_webui_secret.path
        ];

        environment = {
          "OLLAMA_BASE_URL" = "http://ollama:11434";
        };

        volumes = [ "open-webui_data:/app/backend/data" ];
        dependsOn = [ "ollama" ];
        extraOptions = [ "--network=container:ollama" ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3000 11434 ];
}
