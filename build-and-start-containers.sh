#!/bin/sh

docker build -f Dockerfile -t supersven/ghc-spacemacs .

./start-containers.sh

