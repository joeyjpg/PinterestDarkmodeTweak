TARGET := iphone:clang:latest:6.0
ARCHS = armv7
INSTALL_TARGET_PROCESSES = Pinterest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PinterestDarkMode
PinterestDarkMode_FILES = Tweak.xm
PinterestDarkMode_FRAMEWORKS = UIKit
PinterestDarkMode_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
