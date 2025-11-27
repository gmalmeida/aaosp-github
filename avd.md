If you want to use your AAOS build output (out/target/product/emulator_car64_x86_64/), you need to package it into the SDK system-images layout so avdmanager can see it:
```bash
mkdir -p $ANDROID_SDK_ROOT/system-images/android-35/android-automotive/x86_64
```
Copy your built images:
```bash
cp out/target/product/emulator_car64_x86_64/system.img \
   out/target/product/emulator_car64_x86_64/vendor.img \
   out/target/product/emulator_car64_x86_64/product.img \
   out/target/product/emulator_car64_x86_64/ramdisk.img \
   out/target/product/emulator_car64_x86_64/vbmeta.img \
   $ANDROID_SDK_ROOT/system-images/android-35/android-automotive/x86_64/
```
Add metadata files (sources.properties and package.xml) describing the image (API level 35, tag android-automotive, ABI x86_64). Example sources.properties:
```
Pkg.Desc=Android Automotive OS (local build)
Pkg.Revision=1
AndroidVersion.ApiLevel=35
SystemImage.Abi=x86_64
SystemImage.TagId=android-automotive
SystemImage.TagDisplay=Android Automotive
```
Now avdmanager will recognize system-images;android-35;android-automotive;x86_64.


# Create a car AVD via avdmanager
Create the AVD:

```bash
AVD_NAME="aaos-car-x86_64-local"
$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager create avd \
  --name "$AVD_NAME" \
  --device "Automotive" \
  --package "system-images;android-35;android-automotive;x86_64" \
  --abi "x86_64"
```
If “Automotive” device profile is missing, you can create with a generic profile and edit later:

```bash
$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager create avd \
  --name "$AVD_NAME" \
  --package "system-images;android-35;android-automotive;x86_64" \
  --abi "x86_64"
```
# Set car-specific hardware config (recommended)
Edit ~/.android/avd/aaos-car-x86_64-local.avd/config.ini and add:

```
hw.mainKeys=yes
hw.lcd.width=1920
hw.lcd.height=1080
hw.lcd.depth=16
hw.lcd.density=240
hw.initialOrientation=landscape
hw.multi_display=true
hw.camera.back=none
hw.camera.front=none
hw.keyboard=yes
playstore.enabled=false
tag.id=android-automotive
tag.display=Android Automotive

hw.cpu.ncore=4
hw.ramSize=4096
hw.accelerometer=yes
hw.gpu.enabled=yes
hw.gpu.mode=host
```
For multi-display testing, you can add additional displays via the emulator Extended Controls UI or supply -feature MultiDisplays at launch.

# Launch the AVD

```bash
$SDK_ROOT/emulator/emulator -avd aaos-car-x86_64-local \
  -verbose \
  -gpu host \
  -no-snapshot \
  -no-boot-anim \
  -qemu -enable-kvm
```
# Quick sanity checks
* Verify the emulator finds all images:
  * If direct-launch fails, confirm each .img path exists and is readable.
* Ensure adb sees the device:
```bash
adb devices
```
* Confirm car services:
```bash
adb logcat -s CarService CarInfoManager CarLauncher
```

# Launch AVD
```bash
emulator -avd aaos-car-x86_64-local -verbose -no-snapshot -no-boot-anim
```
