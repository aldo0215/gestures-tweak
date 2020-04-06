THEOS_DEVICE_IP = root@192.168.0.169
ARCHS = arm64

DEBUG = 0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = gestures

gestures_FILES = Tweak.x
gestures_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
