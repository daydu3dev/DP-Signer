#!/usr/bin/env bash
set -euo pipefail
TARBALL_URL="https://github.com/linux-is-goat/DP-Signer/raw/refs/heads/main/uboot-vboot-tools.tar.gz"

if [[ "$EUID" -eq 0 ]]; then
    echo "✓ Running as root. good boy"
else
    echo "very bad run as root"
    exit 1
fi

echo "Detecting environment and setting up workspace..."
TMP_DIR="/usr/local/tmp"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
echo "Installing dependencies..."
curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TMP_DIR}"  
