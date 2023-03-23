export TARGET_CODESIGN_FLAGS="-Sentitlements.xml"
#export ARCHS = armv7 armv7s arm64
#export TARGET = iphone:clang:latest:14.0.0
ARCHS := arm64 arm64e
TARGET := iphone:clang:13.7:14.0.0
GO_EASY_ON_ME=1

include $(THEOS)/makefiles/common.mk

TOOL_NAME = memscan
memscan_FILES = main.mm

GIT_VERSION := $(shell git describe --abbrev=4 --dirty --always --tags)

ADDITIONAL_CFLAGS = -Wno-format -Wno-error -Wno-unused-variable -Wno-c++11-compat-deprecated-writable-strings -Wno-unused-value -DVERSION=\"$(GIT_VERSION)\"

include $(THEOS_MAKE_PATH)/tool.mk

before-package::
	touch -r $(THEOS_STAGING_DIR)/usr/bin/memscan $(THEOS_STAGING_DIR)
	touch -r $(THEOS_STAGING_DIR)/usr/bin/memscan $(THEOS_STAGING_DIR)/DEBIAN
	touch -r $(THEOS_STAGING_DIR)/usr/bin/memscan $(THEOS_STAGING_DIR)/DEBIAN/*
	touch -r $(THEOS_STAGING_DIR)/usr/bin/memscan $(THEOS_STAGING_DIR)/usr
	touch -r $(THEOS_STAGING_DIR)/usr/bin/memscan $(THEOS_STAGING_DIR)/usr/bin
	chmod 0755 $(THEOS_STAGING_DIR)/usr/bin/memscan*

after-package::
	rm -fr .theos/packages/*
