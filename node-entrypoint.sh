#!/usr/bin/env sh

set -euo pipefail

apk add --update --no-cache curl

echo $OP_ENGINE_API_JWT > /data/jwt

exec op-node