{ pkgs }:

let
  base = import ./default.nix { inherit pkgs; };
in
pkgs.mkShell {
  name = "node";

  packages = with pkgs; [
    nodejs_22
    nodePackages.npm
    nodePackages.prettier
  ] ++ base.basePkgs;

  shellHook = ''
    if [ ! -d "$PWD/node_modules" ] && [ -f "$PWD/package.json" ]; then
      echo "[nix] Instalando dependencias npm ..."
      npm install
    fi

    echo "[nix] node shell listo: $(node --version) | npm $(npm --version)"
  '';
}
