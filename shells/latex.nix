{ pkgs }:

let
  base = import ./default.nix { inherit pkgs; };

  # Amplia el scheme-medium con los paquetes que uses habitualmente.
  # Busca nombres en https://search.nixos.org filtrando por texlive.
  latexEnv = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium
      latexmk
      tcolorbox
      pgf
      environ
      etoolbox
      xcolor
      fontawesome5
      ;
  };
in
pkgs.mkShell {
  name = "latex";

  packages = [
    latexEnv
    pkgs.texlab        # LSP para editores
    pkgs.ghostscript   # Necesario para algunas operaciones de PDF
  ] ++ base.basePkgs;

  shellHook = ''
    echo "[nix] latex shell listo: $(latexmk --version | head -1)"
  '';
}
