LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

#LOCAL_PACKAGE_NAME := VolantisLayoutDroneLS5P6818
LOCAL_PACKAGE_NAME := VolantisLayouts5p6818_drone

LOCAL_SDK_VERSION := current

include $(BUILD_PACKAGE)
