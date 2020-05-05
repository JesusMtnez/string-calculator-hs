let
  pkgs = import <nixpkgs> {};
  ghcide = import (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.haskell.compiler.ghc865
    pkgs.haskellPackages.cabal-install
    pkgs.haskellPackages.hlint
    pkgs.haskellPackages.stylish-haskell
    pkgs.cabal2nix
    ghcide.ghcide-ghc865
  ];
  shellHook = ''
export NIX_GHC="$(which ghc)"
export NIX_GHCPKG="$(which ghc-pkg)"
export NIX_GHC_DOCDIR="$NIX_GHC/../../share/doc/ghc/html"
export NIX_GHC_LIBDIR="$(ghc --print-libdir)"
'';
}
