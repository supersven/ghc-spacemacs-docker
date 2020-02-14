import ./ghc.nix/default.nix {
  bootghc = "ghc865";
  withIde = true;
  withHadrianDeps = true;
  cores = 8;
  withDocs = false;
}
