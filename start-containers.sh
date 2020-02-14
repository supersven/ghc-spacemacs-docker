#!/bin/sh

docker run -d \
--name x11-bridge \
-e MODE="tcp" \
-e XPRA_HTML="yes" \
-e DISPLAY=:14 \
-e XPRA_PASSWORD=111 \
--net=host \
jare/x11-bridge

timeout 300 sh -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:10000)" != "200" ]]; do sleep 5; done' || false

docker run -d \
--name ghc-spacemacs \
--mount type=bind,source="$PWD"/config/.spacemacs,target=/root/.spacemacs \
--volumes-from x11-bridge \
-e DISPLAY=:14 \
supersven/ghc-spacemacs:latest \
emacs --maximized

