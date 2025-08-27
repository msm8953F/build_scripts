#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf android_device_xiaomi_daisy


# Initialize local repository
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
#git clone https://github.com/msm8953F/android_device_xiaomi_daisy -b Alpha-15 device/xiaomi/daisy
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

# Export
export BUILD_USERNAME=achu 
export BUILD_HOSTNAME=crave_x_shaaim
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export SELINUX_IGNORE_NEVERALLOWS=true
echo "======= Export Done ======"

# aging 
#rm -rf packages/apps/Settings
#git clone https://github.com/frnwot/android_packages_apps_Settings_crd.git -b 15.0 packages/apps/Settings
rm -rf device/xiaomi/daisy
git clone https://github.com/msm8953F/android_device_xiaomi_daisy -b Axion-qpr2 device/xiaomi/daisy

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
. build/envsetup.sh
brunch daisy


