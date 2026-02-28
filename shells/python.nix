{ pkgs }:

let
  base = import ./default.nix { inherit pkgs; };

  pythonEnv = pkgs.python312;

  buildDeps = with pkgs; [
    gcc
    cmake
    gnumake
    pkg-config
    stdenv.cc.cc.lib
  ];
in
pkgs.mkShell {
  name = "python";

  packages = [
    pythonEnv
    pythonEnv.pkgs.pip
    pythonEnv.pkgs.virtualenv
  ] ++ buildDeps ++ base.basePkgs;

  # Necesario para que los compiled wheels encuentren las libs de C++
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ]);

  shellHook = ''
    VENV_DIR="$PWD/.venv"

    if [ ! -d "$VENV_DIR" ]; then
      echo "[nix] Creando venv en .venv/ ..."
      python -m venv "$VENV_DIR"
      source "$VENV_DIR/bin/activate"
      echo "[nix] Actualizando pip ..."
      pip install --upgrade pip
      if [ -f "$PWD/requirements.txt" ]; then
        echo "[nix] Instalando dependencias desde requirements.txt ..."
        pip install -r "$PWD/requirements.txt"
      fi
    else
      source "$VENV_DIR/bin/activate"
    fi

    echo "[nix] python shell listo: $(python --version)"
  '';
}
