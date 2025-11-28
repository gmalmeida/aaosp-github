# General 
This repo intends to capture tips and tricks for building AAOS (vanila) 

Source: https://source.android.com/docs/setup/download

# Introductions

```bash
# --- Step 1: Create a fresh working directory
# (Keeps AAOS sources separate from other AOSP checkouts)
mkdir -p aaos-15 && cd aaos-15

# --- Step 2: Initialize repo with Android 15 manifest
# Replace android-15.0.0_r1 with the exact release tag you want
repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r1

# OR GOOGLE OFFICIAL documentation 
repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest

# --- Step 3: Sync all sources
# -j$(nproc) uses all CPU cores for faster sync
# -c ensures current branch only
# --fetch-submodules pulls in any git submodules
# --force-sync cleans up mismatches
# repo sync -j$(nproc) -c --fetch-submodules --force-sync
# if you get the message "Resource has been exhausted (e.g. check quota)", you can reduce the number of jobs
# repo sync -j4 -c --fetch-submodules --force-sync

# GOOGLE OFFICIAL documentation
repo sync -c -j8

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

export TARGET_RELEASE=ap2a
build_build_var_cache
lunch
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

#Artifacts will appear under:
out/target/product/emulator_car64_x86_64/



```
