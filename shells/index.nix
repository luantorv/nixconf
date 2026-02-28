{ pkgs }:

{
  default = (import ./default.nix { inherit pkgs; }).shell;
  python  = import ./python.nix  { inherit pkgs; };
  node    = import ./node.nix    { inherit pkgs; };
  rust    = import ./rust.nix    { inherit pkgs; };
  latex   = import ./latex.nix   { inherit pkgs; };
}
