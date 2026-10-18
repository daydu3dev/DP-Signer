#!/usr/bin/env bash
set -euo pipefail

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
