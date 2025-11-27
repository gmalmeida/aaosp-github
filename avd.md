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
Add metadata files (sources.properties and package.xml (under the above directory) describing the image (API level 35, tag android-automotive, ABI x86_64). Example sources.properties:

`sources.properties`
```
Pkg.Desc=Android Automotive OS (local build)
Pkg.Revision=1
AndroidVersion.ApiLevel=35
SystemImage.Abi=x86_64
SystemImage.TagId=android-automotive
SystemImage.TagDisplay=Android Automotive
```
`package.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ns2:repository xmlns:ns2="http://www.android.com/repository"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <localPackage path="system-images;android-35;android-automotive;x86_64" version="1">
    <type-details xsi:type="ns2:sysImgDetailsType">
      <apiLevel>35</apiLevel>
      <tag>
        <id>android-automotive</id>
        <display>Android Automotive</display>
      </tag>
      <abi>x86_64</abi>
    </type-details>
    <channelRef ref="stable"/>
  </localPackage>
</ns2:repository>
```

Now avdmanager will recognize system-images;android-35;android-automotive;x86_64.

```console
gabriel@android:~/android-sdk/system-images/android-35/android-automotive/x86_64$ ll
total 1595536
drwxrwxr-x 2 gabriel gabriel       4096 Nov 27 14:36 ./
drwxrwxr-x 3 gabriel gabriel       4096 Nov 27 14:31 ../
-rw-rw-r-- 1 gabriel gabriel        547 Nov 27 14:36 package.xml
-rw-rw-r-- 1 gabriel gabriel  290586624 Nov 27 14:32 product.img
-rw-rw-r-- 1 gabriel gabriel    2065247 Nov 27 14:32 ramdisk.img
-rw-rw-r-- 1 gabriel gabriel        189 Nov 27 14:36 sources.properties
-rw-rw-r-- 1 gabriel gabriel 1224155136 Nov 27 14:32 system.img
-rw-rw-r-- 1 gabriel gabriel       8192 Nov 27 14:32 vbmeta.img
-rw-rw-r-- 1 gabriel gabriel  118202368 Nov 27 14:32 vendor.img
```

# Run the emulator

```console
$ANDROID_SDK_ROOT/emulator/emulator \
  -verbose \
  -gpu host \
  -no-snapshot \
  -no-boot-anim \
  -partition-size 2048 \
  -qemu -enable-kvm \
  -writable-system \
  -system out/target/product/emulator_car64_x86_64/system.img \
  -vendor out/target/product/emulator_car64_x86_64/vendor.img \
  -product out/target/product/emulator_car64_x86_64/product.img \
  -ramdisk out/target/product/emulator_car64_x86_64/ramdisk.img \
  -vbmeta out/target/product/emulator_car64_x86_64/vbmeta.img
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
