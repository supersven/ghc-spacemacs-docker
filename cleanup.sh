#!/bin/sh

docker stop ghc-spacemacs
docker stop x11-bridge

docker rm ghc-spacemacs
docker rm x11-bridge
