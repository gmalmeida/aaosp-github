#!/bin/bash
# AAOS Build Script
# Usage: ./scripts/build.sh [target]
# Default target: sdk_car_x86_64-ap3a-userdebug

set -e

AAOS_ROOT="${HOME}/aaosp-github/source"
TARGET="${1:-sdk_car_x86_64-ap3a-userdebug}"

if [ ! -d "$AAOS_ROOT" ]; then
    echo "Error: AAOS source not found at $AAOS_ROOT"
    echo "Run repo sync first. See README.md for instructions."
    exit 1
fi

cd "$AAOS_ROOT"

echo "=== Setting up build environment ==="
source build/envsetup.sh

echo "=== Selecting target: $TARGET ==="
lunch "$TARGET"

echo "=== Starting build ==="
m -j$(nproc)

echo "=== Build complete ==="
echo "Output: $AAOS_ROOT/out/target/product/"
