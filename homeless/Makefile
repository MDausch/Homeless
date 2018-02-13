include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = homeless
homeless_FILES = mdhlRootListController.m
homeless_INSTALL_PATH = /Library/PreferenceBundles
homeless_FRAMEWORKS = UIKit
homeless_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/homeless.plist$(ECHO_END)
