#!/bin/bash
# AAOS Development Dependencies Setup
# Run this on a fresh Ubuntu machine to install everything needed
# Usage: sudo ./scripts/setup-deps.sh

set -e

echo "=== Installing AAOS/AOSP build dependencies ==="

# Core build tools
sudo apt-get update
sudo apt-get install -y \
    git-core gnupg flex bison build-essential \
    zip curl zlib1g-dev libc6-dev-i386 \
    libncurses5 x11proto-core-dev libx11-dev \
    lib32z1-dev libgl1-mesa-dev libxml2-utils \
    xsltproc unzip fontconfig python3 python3-pip \
    openjdk-17-jdk repo

# Additional tools for emulator
sudo apt-get install -y \
    qemu-kvm libvirt-daemon-system \
    bridge-utils virt-manager

# Repo tool (if not installed via apt)
if ! command -v repo &> /dev/null; then
    echo "Installing repo tool..."
    mkdir -p ~/bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
fi

echo ""
echo "=== Dependencies installed ==="
echo "Next steps:"
echo "  1. mkdir -p ~/aaosp-github/source && cd ~/aaosp-github/source"
echo "  2. repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1"
echo "  3. repo sync -c -j\$(nproc) --no-tags"
echo "  4. ./scripts/build.sh"
