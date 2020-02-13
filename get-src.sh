#!/bin/sh

# Create a `ghc` source folder with `ghc.nix` in place.
git clone --recurse-submodules https://gitlab.haskell.org/ghc/ghc
git clone https://github.com/alpmestan/ghc.nix.git ghc/ghc.nix
