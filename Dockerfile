FROM nixorg/nix

# Update Nix packages.
RUN nix-channel --add https://nixos.org/channels/nixos-19.09 nixpkgs
RUN nix-channel --update
RUN nix-env -u

# Install required dependencies via Nix.
RUN nix-env -f '<nixpkgs>' -iA gnutar gzip emacs26 ccls

# Install Spacemacs and switch to the `develop` branch.
RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
WORKDIR /root/.emacs.d
RUN git checkout --track origin/develop && git pull

# Install and enable `cachix` for `ghcide-nix`.
RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN USER=root cachix use ghcide-nix

# Run `nix-shell` to get all `ghc.nix` dependencies. And use `hadrian` to build
# the project.
WORKDIR /root

COPY /get-src.sh .
COPY /config config

RUN ./get-src.sh

# Use the `config` folder as an overlay to the `ghc` source directory.
RUN cp -r config/ghc/* ghc

WORKDIR /root/ghc
RUN nix-shell --command 'cabal update'
RUN nix-shell --command 'hadrian/build.sh -c -j12 --docs=none --flavour=Devel2'

# Setup Spacemacs (mainly install all packages)
COPY /config/.spacemacs /root/.spacemacs
RUN emacs -batch -l ~/.emacs.d/init.el --eval "(run-hooks 'emacs-startup-hook)"

# haskell-mode needs a GHC. Use GHC 8.6.5 because `nix-shell` already installed
# it (see `shell.nix`).
RUN nix-env -f '<nixpkgs>' -iA haskell.compiler.ghc865

# Create `compile_commands.json` (C IDE support)
RUN nix-env -f '<nixpkgs>' -i bear
RUN nix-shell --command 'bear hadrian/build.sh -j12 --freeze1 --flavour=Devel2 stage2:lib:rts'

