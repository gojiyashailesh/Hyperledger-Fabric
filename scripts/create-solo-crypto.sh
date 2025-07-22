#!/bin/bash

set -euo pipefail
trap 'echo -e "\n❌ Error occurred. Exiting." >&2' ERR

# --- Colored Logging ---
info()    { echo -e "🟦 \033[1;34m$1\033[0m"; }
success() { echo -e "✅ \033[1;32m$1\033[0m"; }
error()   { echo -e "❌ \033[1;31m$1\033[0m"; }

# --- Usage Help ---
if [[ $# -ne 1 ]]; then
  echo "Usage: ./scripts/create-crypto.sh [solo|raft]"
  exit 1
fi

MODE=$1
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CRYPTOGEN_BIN="$(which cryptogen)"
CONFIG_FILE="$PROJECT_ROOT/cryptogen/$MODE/crypto-config.yaml"
OUTPUT_DIR="$PROJECT_ROOT/cryptogen/$MODE/crypto-config"

# --- Validations ---
if [[ ! -f "$CONFIG_FILE" ]]; then
  error "Missing config file: $CONFIG_FILE"
  exit 1
fi

if [[ -z "$CRYPTOGEN_BIN" ]]; then
  error "cryptogen binary not found in PATH"
  exit 1
fi

# --- Execution ---
info "🔧 Mode: $MODE"
info "Cleaning previous crypto material at $OUTPUT_DIR..."
rm -rf "$OUTPUT_DIR"

info "Generating crypto material using config: $CONFIG_FILE"
$CRYPTOGEN_BIN generate --config="$CONFIG_FILE" --output="$OUTPUT_DIR"

success "Crypto material generated successfully in: $OUTPUT_DIR"
