#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf android_device_xiaomi_daisy


# repo init rom
repo init -u https://github.com/DerpFest-AOSP/android_manifest.git -b 16 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/msm8953F/android_device_xiaomi_daisy -b Axion-qpr2 device/xiaomi/daisy
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# remove face unlock 
#rm -rf packages/apps/FaceUnlock

rm -rf device/xiaomi/daisy
git clone https://github.com/frnwot/android_device_xiaomi_daisy_standard -b derp/15 device/xiaomi/daisy

# Export
export BUILD_USERNAME=achu 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export SELINUX_IGNORE_NEVERALLOWS=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
. build/envsetup.sh
lunch lineage_daisy-bp2a-user
# Run to prepare our devices list
# ... now run
mka derp

