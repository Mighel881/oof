export TARGET = iphone:11.2:9.0

INSTALL_TARGET_PROCESSES = SpringBoard

export ADDITIONAL_CFLAGS = -DTHEOS_LEAN_AND_MEAN -fobjc-arc

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = oof
oof_FILES = $(wildcard *.[xm])
oof_FRAMEWORKS = UIKit AVFoundation
oof_EXTRA_FRAMEWORKS = Cephei

BUNDLE_NAME = foo
foo_INSTALL_PATH = /var/mobile/Library/oof/

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS)/makefiles/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
