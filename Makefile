TARGET := iphone:clang:latest:15.0
ARCHS := arm64 arm64e
INSTALL_TARGET_PROCESSES := Locket

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := LocketTok
LocketTok_FILES := Tweak.x
LocketTok_CFLAGS := -fobjc-arc

include $(THEOS)/makefiles/tweak.mk
