{ pkgs }:

let
  base = import ./default.nix { inherit pkgs; };
in
pkgs.mkShell {
  name = "rust";

  packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    pkg-config
    openssl
  ] ++ base.basePkgs;

  # Necesario para crates que linkean contra openssl
  OPENSSL_DIR = "${pkgs.openssl.dev}";
  OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  shellHook = ''
    echo "[nix] rust shell listo: $(rustc --version) | $(cargo --version)"
  '';
}
