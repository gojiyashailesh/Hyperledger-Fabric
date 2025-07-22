#!/bin/bash

set -e

# Absolute or relative path to configtx.yaml
export FABRIC_CFG_PATH="$(cd ../configtx && pwd)"

CHANNEL_NAME="everycredchannel"
GENESIS_PROFILE="EveryCREDGenesis"
CHANNEL_PROFILE="EveryCREDChannel"
SYS_CHANNEL="system-channel"
OUTPUT_DIR="../channel-artifacts"
ORG_NAME="EveryCRED"
ANCHOR_TX="${ORG_NAME}MSPanchors.tx"

mkdir -p "$OUTPUT_DIR"

echo "FABRIC_CFG_PATH is set to: $FABRIC_CFG_PATH"

echo "Generating Genesis block..."
configtxgen -profile "$GENESIS_PROFILE" \
  -channelID "$SYS_CHANNEL" \
  -outputBlock "${OUTPUT_DIR}/genesis.block"

echo "Generating Channel creation transaction..."
configtxgen -profile "$CHANNEL_PROFILE" \
  -outputCreateChannelTx "${OUTPUT_DIR}/channel.tx" \
  -channelID "$CHANNEL_NAME"

echo "Generating Anchor Peer update transaction for ${ORG_NAME}..."
configtxgen -profile "$CHANNEL_PROFILE" \
  -outputAnchorPeersUpdate "${OUTPUT_DIR}/${ANCHOR_TX}" \
  -channelID "$CHANNEL_NAME" \
  -asOrg "${ORG_NAME}"

echo "Encoding config block as JSON (for debug/reference)..."
configtxgen -inspectBlock "${OUTPUT_DIR}/genesis.block" > "${OUTPUT_DIR}/genesis_block.json"
configtxgen -inspectChannelCreateTx "${OUTPUT_DIR}/channel.tx" > "${OUTPUT_DIR}/channel_tx.json"
configtxgen -inspectChannelCreateTx "${OUTPUT_DIR}/${ANCHOR_TX}" > "${OUTPUT_DIR}/anchor_tx.json"

echo "✅ All artifacts generated in: ${OUTPUT_DIR}"
