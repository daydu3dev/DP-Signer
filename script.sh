#!/usr/bin/env bash
set -euo pipefail
if sudo -n -v 2>/dev/null; then
    echo "✓ User has active sudo privileges. good boy"
else
    echo "very bad run as root"
   
fi
echo "Detecting environment and setting up workspace..."
TMP_DIR="/usr/local/tmp"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
echo "Installing dependencies..."
