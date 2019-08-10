export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=22222

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = tweak_test

tweak_test_FILES = Tweak.x
tweak_test_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
