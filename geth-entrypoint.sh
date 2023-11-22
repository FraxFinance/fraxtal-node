#!/usr/bin/env sh

set -euo pipefail

apk add --update --no-cache curl

if [ ! -d /data/geth ]; then
    geth init --datadir /data /data/genesis.json
fi;

echo $OP_ENGINE_API_JWT > /data/jwt

exec geth