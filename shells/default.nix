{ pkgs }:

# Exporta tanto el shell standalone como la lista de paquetes base
# para que los demas shells puedan extenderlo sin duplicar.
let
  basePkgs = with pkgs; [
    git
    lazygit
    curl
    jq
    wget
    ripgrep
    fd
  ];
in
{
  inherit basePkgs;

  shell = pkgs.mkShell {
    name = "default";
    packages = basePkgs;
    shellHook = ''
      echo "[nix] default shell listo."
    '';
  };
}
