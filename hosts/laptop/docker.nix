{ pkgs, globalVars, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker
  ];

  # Requisito: Los usuarios rootless necesitan un rango de IDs asignados.
  # NixOS maneja esto automáticamente al habilitar virtualisation.docker.rootless,
  # pero asegúrate de que tu usuario esté en el grupo 'docker' si quisieras
  # usar el modo normal en algún momento.
  users.users.${globalVars.username}.extraGroups = [ "docker" ];
}
