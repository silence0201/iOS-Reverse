# Config
ARCH = armv7
IOS_VERSION = 8.0
EXECUTABLE_NAME = TestMachO

# Dirs
RELEASE_DIR = Release
PROJECT_DIR = TestMachO
EXECUTABLE_FILE = $(RELEASE_DIR)/$(EXECUTABLE_NAME)

# Header Files
HEADER_DIR1 = $(PROJECT_DIR)
HEADER_DIR2 = $(PROJECT_DIR)/MachInfo

# Source Files
SOURCE_FILES = $(HEADER_DIR1)/*.m
SOURCE_FILES += $(HEADER_DIR2)/*.m

# Entitlements
ENTITLEMENT_FILE = $(RELEASE_DIR)/TestMachO.entitlements

codesign: compile
	@codesign -fs- --entitlements $(ENTITLEMENT_FILE) $(EXECUTABLE_FILE)

compile:
	@xcrun -sdk iphoneos \
		clang -arch $(ARCH) \
		-mios-version-min=$(IOS_VERSION) \
		-fobjc-arc \
		-framework Foundation \
		-framework UIKit \
		-framework MobileCoreServices \
		-Os \
		-I $(HEADER_DIR1) \
		-I $(HEADER_DIR2) \
		$(SOURCE_FILES) \
		-o $(EXECUTABLE_FILE)