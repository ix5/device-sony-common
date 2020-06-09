# This file specifies exemptions for modules which either:
# - Do not for the given device/platform
# - Are only conditionally available
# - Are part of proprietary builds

# To be used together with PRODUCT_ENFORCE_PACKAGES_EXIST

# Android Q has a bug where it doesn't consider bitness suffixes
# Fixed in R with https://android-review.googlesource.com/c/platform/build/+/975126
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    android.hardware.audio.effect@5.0-impl:32 \
    android.hardware.audio@5.0-impl:32 \
    android.hardware.bluetooth@1.0-impl-qti \
    android.hardware.camera.provider@2.4-impl:64 \
    android.hardware.graphics.composer@2.3-impl:64 \
    android.hardware.sensors@1.0-impl:64

# Part of the proprietary build
# Should be moved to common-odm.mk
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    camera.msm8998 \
    camera.sdm660 \
    camera.sdm845 \
    camera.sm8150 \
    camera.sm6125

# Otherwise not available or unused legacy HAL modules
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    copybit.$(TARGET_BOARD_PLATFORM) \
    gps.$(TARGET_BOARD_PLATFORM)

# Conditionally available init modules
# Should only be included for the appropriate platforms rather than hiding them
# behind guards
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    audiopd.rc \
    qmuxd.rc

# Nonexistent apps
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    InCallUI \

# Nonexistent, obsolete or no-longer-existent libs
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    libLLVM \
    libOmxVdecHevc \
    libhdmi \
    libloc_ds_api \
    libloc_pla
    libmm-qcamera \
    libmmcamera_interface \
    libmmjpeg_interface \
    libmmlib2d_interface \
    libqomx_core

# NFC firmware blobs
# Should only conditionally be included rather than inheriting nxp-vendor.mk
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    libpn547_fw \
    libpn548_fw \
    libpn551_fw \
    libpn553_fw

# This module is defined in system/libhidl/vintfdata/Android.mk
# but hidden behind PRODUCT_MANIFEST_FILES
PRODUCT_ENFORCE_PACKAGES_EXIST_WHITELIST += \
    product_manifest.xml
