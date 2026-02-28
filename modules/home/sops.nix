{ config, pkgs, globalVars, sops-nix, ... }:

{
  imports = [ sops-nix.homeManagerModules.sops ];

  sops = {
    # Clave con la que sops descifra. Deriva una clave age a partir de tu clave SSH ed25519.
    age.sshKeyPaths = [ "${globalVars.homeDirectory}/.ssh/id_ed25519" ];

    # Archivo donde sops guarda la clave age derivada (no es un secreto, puede estar en el store)
    age.keyFile = "${globalVars.homeDirectory}/.config/sops/age/keys.txt";
    age.generateKey = false; # La clave la generamos nosotros, no sops

    defaultSopsFile = ../../secrets/secrets.yaml;

    secrets = {
      # Cada secreto declara su path de destino y sus permisos.
      # sops los deposita fuera del nix store, bajo /run/user/<uid>/secrets/ por defecto.
      "ssh/id_ed25519" = {
        path = "${globalVars.homeDirectory}/.ssh/id_ed25519";
        mode = "0600";
      };
      "ssh/id_ed25519.pub" = {
        path = "${globalVars.homeDirectory}/.ssh/id_ed25519.pub";
        mode = "0644";
      };
    };
  };
}