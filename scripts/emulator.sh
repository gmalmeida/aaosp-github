#!/bin/bash
# AAOS Emulator Launch Script
# Usage: ./scripts/emulator.sh

set -e

AAOS_ROOT="${HOME}/aaosp-github/source"

if [ ! -d "$AAOS_ROOT" ]; then
    echo "Error: AAOS source not found at $AAOS_ROOT"
    exit 1
fi

cd "$AAOS_ROOT"

# Set up environment if not already done
if [ -z "$ANDROID_BUILD_TOP" ]; then
    echo "=== Setting up build environment ==="
    source build/envsetup.sh
    lunch sdk_car_x86_64-ap3a-userdebug
fi

echo "=== Launching AAOS Emulator ==="
emulator -no-snapshot -wipe-data &

echo "Emulator launched. Use 'adb devices' to verify."
echo "To stop: kill %1 or close the emulator window."
