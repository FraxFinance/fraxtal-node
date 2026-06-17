#!/bin/bash
set -eu

apt update && apt install -y curl

if [[ -z "${OP_ENGINE_API_JWT:-}" ]]; then
    echo "Error: OP_ENGINE_API_JWT is required" >&2
    exit 1
fi

if [[ -z "${RETH_SEQUENCER_HTTP:-}" ]]; then
    echo "Error: RETH_SEQUENCER_HTTP is required" >&2
    exit 1
fi

RETH_CHAIN="${RETH_CHAIN:-fraxtal}"
RETH_DATA_DIR="${RETH_DATA_DIR:-/data}"
RETH_RPC_PORT="${RETH_RPC_PORT:-8545}"
RETH_WS_PORT="${RETH_WS_PORT:-8546}"
RETH_AUTHRPC_PORT="${RETH_AUTHRPC_PORT:-8551}"
RETH_METRICS_PORT="${RETH_METRICS_PORT:-6060}"
RETH_DISCOVERY_PORT="${RETH_DISCOVERY_PORT:-30303}"
RETH_P2P_PORT="${RETH_P2P_PORT:-30303}"
RETH_HTTP_ADDR="${RETH_HTTP_ADDR:-0.0.0.0}"
RETH_HTTP_API="${RETH_HTTP_API:-web3,debug,eth,net,txpool}"
RETH_WS_ADDR="${RETH_WS_ADDR:-0.0.0.0}"
RETH_WS_API="${RETH_WS_API:-web3,debug,eth,net,txpool}"
RETH_AUTHRPC_ADDR="${RETH_AUTHRPC_ADDR:-0.0.0.0}"
RETH_METRICS_ADDR="${RETH_METRICS_ADDR:-0.0.0.0}"
RETH_LOG_LEVEL="${RETH_LOG_LEVEL:-info}"

mkdir -p "$RETH_DATA_DIR"
echo "$OP_ENGINE_API_JWT" > "$RETH_DATA_DIR/jwt"
case "$RETH_LOG_LEVEL" in
    "error") VERBOSITY="v" ;;
    "warn")  VERBOSITY="vv" ;;
    "info")  VERBOSITY="vvv" ;;
    "debug") VERBOSITY="vvvv" ;;
    "trace") VERBOSITY="vvvvv" ;;
    *)       VERBOSITY="vvv" ;;
esac

ADDITIONAL_ARGS="${RETH_ADDITIONAL_ARGS:-}"

if [[ -n "${RETH_BOOTNODES:-}" ]]; then
    ADDITIONAL_ARGS="$ADDITIONAL_ARGS --bootnodes=$RETH_BOOTNODES"
fi

exec fraxtal-op-reth node \
    -$VERBOSITY \
    --chain="$RETH_CHAIN" \
    --datadir="$RETH_DATA_DIR" \
    --http \
    --http.corsdomain="*" \
    --http.addr="$RETH_HTTP_ADDR" \
    --http.port="$RETH_RPC_PORT" \
    --http.api="$RETH_HTTP_API" \
    --ws \
    --ws.origins="*" \
    --ws.addr="$RETH_WS_ADDR" \
    --ws.port="$RETH_WS_PORT" \
    --ws.api="$RETH_WS_API" \
    --authrpc.addr="$RETH_AUTHRPC_ADDR" \
    --authrpc.port="$RETH_AUTHRPC_PORT" \
    --authrpc.jwtsecret="$RETH_DATA_DIR/jwt" \
    --metrics="$RETH_METRICS_ADDR":"$RETH_METRICS_PORT" \
    --rollup.sequencer-http="$RETH_SEQUENCER_HTTP" \
    --rollup.disable-tx-pool-gossip \
    --discovery.port="$RETH_DISCOVERY_PORT" \
    --port="$RETH_P2P_PORT" \
    $ADDITIONAL_ARGS
