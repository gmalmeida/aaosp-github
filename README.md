# General 
This repo intends to capture tips and tricks for building AAOS (vanila) 

Source: https://source.android.com/docs/setup/download

# Docker Installation (recommended)
```
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add docker key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# add docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# test the installation 
sudo docker run hello-world

# if you want to run docker without sudo 
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# now you are ready to build and run
docker build -t aosp-build .
docker run -it --rm -v /path/do/seu/aosp:/home/builder/aosp aosp-build

# now let's navigate to the folder anb build AAOS
cd aosp
source build/envsetup.sh
lunch aosp_cf_x86_64_auto_ap2a-eng
make -j$(nproc)
```

``` 
# Introductions

```bash

# Install essential packages
sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev \
gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev \
libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig \
python3 python-is-python3 openjdk-11-jdk openjdk-8-jdk qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
                 libxcb-xinerama0 libxcb-xinerama0-dev qtwayland5
# Create a fresh working directory
# (Keeps AAOS sources separate from other AOSP checkouts)
mkdir -p aaos-15 && cd aaos-15

# Install repo tool
sudo apt install curl
mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Add repo to your path
vim ~/.bashrc
# add to the end of the file
PATH=$PATH:~/bin
# source the file
source ~/.bashrc

# Set Git variables
git config --global user.email "gabriel.marchesan-almeida@capgemini.com"
git config --global user.name "Gabriel Almeida" 

# Initialize repo with Android 15 manifest
# Replace android-15.0.0_r1 with the exact release tag you want
repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r1

# OR GOOGLE OFFICIAL documentation 
repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest

# If you want to make a clean repo sync
repo forall -c "git reset --hard HEAD && git clean -fdx"
repo sync -j$(nproc)

# --- Step 3: Sync all sources
# -j$(nproc) uses all CPU cores for faster sync
# -c ensures current branch only
# --fetch-submodules pulls in any git submodules
# --force-sync cleans up mismatches
# repo sync -j$(nproc) -c --fetch-submodules --force-sync
# if you get the message "Resource has been exhausted (e.g. check quota)", you can reduce the number of jobs
# repo sync -j4 -c --fetch-submodules --force-sync

# GOOGLE OFFICIAL documentation
repo sync -c -j8 --fail-fast

# --- Step 4: Set up the build environment
source build/envsetup.sh

# --- Step 5: Choose a valid AAOS lunch target
# Options (from device/generic/car/AndroidProducts.mk):
#   gsi_car_arm64-trunk_staging-userdebug
#   gsi_car_x86_64-trunk_staging-userdebug
#   sdk_car_arm64-trunk_staging-userdebug
#   sdk_car_md_x86_64-trunk_staging-userdebug
#   sdk_car_portrait_x86_64-trunk_staging-userdebug
#   sdk_car_x86_64-trunk_staging-userdebug
#
# Target	Architecture	Form Factor / Notes
# gsi_car_arm64-trunk_staging-userdebug	ARM64	Generic System Image (GSI) for ARM64 devices; staging branch; good for testing AAOS on ARM hardware
# gsi_car_x86_64-trunk_staging-userdebug	x86_64	GSI for x86_64 devices; staging branch; useful for emulators or Intel-based dev boards
# sdk_car_arm64-trunk_staging-userdebug	ARM64	SDK build for ARM64; includes dev tools; good if you’re targeting ARM-based automotive hardware
# sdk_car_md_x86_64-trunk_staging-userdebug	x86_64	SDK build for multi-display (md) setups; useful for testing AAOS with multiple screens
# sdk_car_portrait_x86_64-trunk_staging-userdebug	x86_64	SDK build for portrait orientation; useful for vertical screen layouts (common in some EV dashboards)
# sdk_car_x86_64-trunk_staging-userdebug	x86_64	Standard SDK build for x86_64; most common choice for emulator testing on desktop

export TARGET_RELEASE=trunk_stagin
build_build_var_cache
lunch | grep auto

# OR ALTERNATIVE
# Example: build the x86_64 SDK car emulator image
# lunch sdk_car_x86_64-trunk_staging-userdebug
# lunch is a helper script provided by the Android build system (build/envsetup.sh).
# It sets up environment variables for the build, telling the system:
# Which product/device configuration to build (here: sdk_car_x86_64-trunk_staging).
# Which build variant to use (here: userdebug).

# --- Step 6: Build the system
# "m" builds everything; -j$(nproc) uses all cores
m -j$(nproc)

# --- Step 7: Locate build artifacts
# Images will be under:
#   out/target/product/sdk_car_x86_64/
# Key files:
#   system.img, vendor.img, boot.img, userdata.img
#
# These can be used to run AAOS in the Android Emulator.

# If you want to build only specific images, you can run:
m systemimage
m vendorimage
m bootimage

# Artifacts will appear under:
out/target/product/vsoc_x86_64/

```
# Running on Emulator

```console
# Make sure you have Android Studio or at least the Android SDK tools installed:
sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

# Ensure your user is in the kvm group:
sudo adduser $USER kvm

``` 
#
