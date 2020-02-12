FROM nixorg/nix

RUN nix-channel --add https://nixos.org/channels/nixos-19.09 nixpkgs
RUN nix-channel --update
RUN nix-env -u

RUN nix-env -f '<nixpkgs>' -iA gnutar gzip emacs26 ccls

RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
WORKDIR /root/.emacs.d
RUN git checkout --track origin/develop && git pull

RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN USER=root cachix use ghcide-nix

WORKDIR /root
