#!/bin/bash
# AAOS Upgrade Test Script
# Simulates upgrade from one AAOS version to another
# Usage: ./scripts/upgrade-test.sh [from_branch] [to_branch]

set -e

FROM_BRANCH="${1:-android-14.0.0_r1}"
TO_BRANCH="${2:-android-15.0.0_r1}"
AAOS_ROOT="${HOME}/aaosp-github/source"

echo "=== AAOS Upgrade Test ==="
echo "From: $FROM_BRANCH"
echo "To:   $TO_BRANCH"
echo ""

# Step 1: Generate diff report
echo "=== Step 1: Analyzing changes ==="
echo "Comparing manifest changes between versions..."

# Step 2: Check for breaking changes in key areas
echo ""
echo "=== Step 2: Key areas to check ==="
AREAS=(
    "packages/services/Car"
    "hardware/interfaces/automotive"
    "packages/apps/Car"
    "device/generic/car"
)

for area in "${AREAS[@]}"; do
    if [ -d "$AAOS_ROOT/$area" ]; then
        echo "  [OK] $area exists"
    else
        echo "  [--] $area not found (may need repo sync)"
    fi
done

# Step 3: Build and test
echo ""
echo "=== Step 3: Build verification ==="
echo "Run ./scripts/build.sh after switching branches to verify build."
echo ""
echo "=== Checklist ==="
echo "[ ] Manifest updated to $TO_BRANCH"
echo "[ ] repo sync completed"
echo "[ ] Build succeeds"
echo "[ ] Emulator boots"
echo "[ ] CarService starts"
echo "[ ] VHAL responds to queries"
echo "[ ] No SELinux denials (check adb logcat | grep avc)"
