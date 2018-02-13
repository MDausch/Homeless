include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Homeless
Homeless_FILES = Homeless.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += homeless
include $(THEOS_MAKE_PATH)/aggregate.mk
