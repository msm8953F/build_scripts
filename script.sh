#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf android_device_xiaomi_daisy


# repo init rom
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 15 -g default,-mips,-darwin,-notdefault
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/msm8953F/android_device_xiaomi_daisy -b Infinity-15/qpr2 device/xiaomi/daisy
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

# repo
rm -rf device/xiaomi/daisy
git clone https://github.com/msm8953F/android_device_xiaomi_daisy -b Infinity-15/qpr2 device/xiaomi/daisy

# play vendor_infinity-priv_keys
git clone https://github.com/ProjectInfinity-X/vendor_infinity-priv_keys-template vendor/infinity-priv/keys
cd vendor/infinity-priv/keys
./keys.sh
cd ../../../
#echo "========================="
#echo "vendor_infinity-priv_keys"
#echo "========================="

# cherry pick 1
cd vendor/infinity
git fetch https://github.com/Gtajisan/vendor_infinity.git
git cherry-pick  05ca5fb2b7c107395df1a32c16f2f89ecebab218
cd ../..

# Export
export BUILD_USERNAME=achu 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export SELINUX_IGNORE_NEVERALLOWS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
. build/envsetup.sh
lunch infinity_daisy-ap4a-userdebug
lunch infinity_daisy-userdebug

# make install
make installclean

# make bacon
mka bacon


