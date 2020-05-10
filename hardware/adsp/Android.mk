# Create symlinks for rfsa libraries.

LOCAL_PATH := $(call my-dir)

include $(SONY_CLEAR_VARS)
LOCAL_MODULE := rfsa_symlinks

library_names := \
    rfsa \

# Create symlinks to 64-bit camera libraries:
SONY_SYMLINKS := $(foreach p,$(library_names), \
    /odm/lib/$p:$(TARGET_COPY_OUT_VENDOR)/lib/$p \
)

include $(SONY_BUILD_SYMLINKS)
