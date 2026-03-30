{ config, pkgs, ... }:

{
  # -------------------------------------------------------------------------
  # Secret: API tokens
  # -------------------------------------------------------------------------
  # Agregar a secrets/secrets.yaml con:
  #   nix run nixpkgs#sops -- secrets/secrets.yaml
  #
  # Formato dentro del YAML:
  #   nixbox:
  #     tokens: |
  #       ANTHROPIC_API_KEY=sk-ant-...
  #       OPENAI_API_KEY=sk-...
  #       GOOGLE_API_KEY=AI...
  sops.secrets.nixbox-tokens = {
    sopsFile = ../../secrets/secrets.yaml;
    key = "nixbox/tokens";
    owner = "nixbox";
    mode = "0400";
  };

  # -------------------------------------------------------------------------
  # Servicio nixbox
  # -------------------------------------------------------------------------
  services.nixbox = {
    enable = true;
    host   = "0.0.0.0";
    port   = 8000;
    tokenFile = config.sops.secrets.nixbox-tokens.path;

    sandboxProfiles = {

      # Perfil para búsqueda de noticias e información general
      news = {
        orchestratorModel = { provider = "google";    model = "gemini-2.0-flash"; };
        executorModel     = { provider = "google";    model = "gemini-2.0-flash"; };
        allowedDomains    = [
          "google.com"
          "wikipedia.org"
          "news.ycombinator.com"
          "reddit.com"
          "bbc.com"
          "reuters.com"
        ];
        allowedActions   = [ "http_get" "write_output" "list_inputs" ];
        allowedLanguages = [];
      };

      # Perfil para tareas de código con acceso a repos y documentación
      code = {
        orchestratorModel = { provider = "anthropic"; model = "claude-opus-4-5"; };
        executorModel     = { provider = "anthropic"; model = "claude-sonnet-4-5"; };
        allowedDomains    = [
          "github.com"
          "gitlab.com"
          "docs.python.org"
          "pypi.org"
          "npmjs.com"
          "crates.io"
          "docs.rs"
          "developer.mozilla.org"
        ];
        allowedActions   = [ "read_input" "write_output" "list_inputs" "http_get" "run_code" "shell" ];
        allowedLanguages = [ "python" "javascript" ];
      };

      # Perfil para código sin acceso a red externa (solo el modelo)
      code-offline = {
        orchestratorModel = { provider = "anthropic"; model = "claude-sonnet-4-5"; };
        executorModel     = { provider = "anthropic"; model = "claude-sonnet-4-5"; };
        allowedDomains    = [];
        allowedActions   = [ "read_input" "write_output" "list_inputs" "run_code" "shell" ];
        allowedLanguages = [ "python" "javascript" ];
      };

    };
  };

  # -------------------------------------------------------------------------
  # Firewall: exponer solo en la interfaz de Tailscale
  # -------------------------------------------------------------------------
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8000 ];
}
