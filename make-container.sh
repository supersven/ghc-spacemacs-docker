#!/bin/sh

./get-src.sh
./copy-config.sh

docker build -f Dockerfile -t supersven/ghc-spacemacs .
docker run -it \
       --name ghc-spacemacs
       --mount type=bind,source="$PWD"/ghc,target=/root/ghc \
       --mount type=bind,source="$PWD"/config/.spacemacs,target=/root/.spacemacs \
       supersven/ghc-spacemacs:latest
