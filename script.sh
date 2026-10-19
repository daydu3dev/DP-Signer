#!/usr/bin/env bash
# BuildCharge credits to kxtz mariah and apple. NOT FROM ME. 
set -euo pipefail
TARBALL_URL="https://github.com/linux-is-goat/DP-Signer/raw/refs/heads/main/uboot-vboot-tools.tar.gz"

if [[ "$EUID" -eq 0 ]]; then
    echo "Running as root. good boy"
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
echo "Detecting system architecture for BuildCharge image..."
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
    BUILDCHARGE_URL="https://github.com/kxtzownsu/buildcharge/releases/download/v1.0.0-buildcharge/buildcharge-x86_64.zip"
    ZIP_FILE="buildcharge-x86_64.zip"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    BUILDCHARGE_URL="https://github.com/kxtzownsu/buildcharge/releases/download/v1.0.0-buildcharge/buildcharge-aarch64.zip"
    ZIP_FILE="buildcharge-aarch64.zip"
else
    echo "Error: Unsupported system architecture: $ARCH"
    exit 1
fi

echo "Downloading BuildCharge payload for $ARCH..."
curl -fsSL "${BUILDCHARGE_URL}" -o "${ZIP_FILE}"

echo "Extracting BuildCharge components..."
unzip -jqo "${ZIP_FILE}" -d "${TMP_DIR}"
rm "${ZIP_FILE}"

echo "BuildCharge should be ready, Continuing"

/usr/bin/clear

export PATH="${TMP_DIR}/uboot-vboot/bin:$PATH"

KPART_FILE=$(ls *.kpart | head -n 1)

