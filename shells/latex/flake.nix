{
  description = "LaTeX Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        tex = pkgs.texliveSmall.withPackages (ps: [
          ps.latexmk
          ps.biber
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ tex ];
        };
      });
}