
系统相关配置和定义，MacOS下的darwin.mk:  
	设置du/md5命令;
	设置sdk环境变量；
	设置Theos系统平台变量

```make
ifeq ($(_THEOS_PLATFORM_LOADED),)
_THEOS_PLATFORM_LOADED := 1
THEOS_PLATFORM_NAME := macosx

ifneq ($(THEOS_CURRENT_ARCH),)
ifneq ($(THEOS_PLATFORM_SDK_ROOT_$(THEOS_CURRENT_ARCH)),)
THEOS_PLATFORM_SDK_ROOT = $(THEOS_PLATFORM_SDK_ROOT_$(THEOS_CURRENT_ARCH))
endif
endif

# 设置SDK_ROOT := '/Applications/Xcode.app/Contents/Developer'
THEOS_PLATFORM_SDK_ROOT ?= $(shell xcode-select -print-path)

# To have xcrun use our customized THEOS_PLATFORM_SDK_ROOT
export DEVELOPER_DIR = $(THEOS_PLATFORM_SDK_ROOT)

_THEOS_PLATFORM_DEFAULT_TARGET := iphone

ifeq ($(call __executable,gdu),$(_THEOS_TRUE))
_THEOS_PLATFORM_DU := gdu
_THEOS_PLATFORM_DU_EXCLUDE := --exclude
else
_THEOS_PLATFORM_DU := du
_THEOS_PLATFORM_DU_EXCLUDE := -I
endif

_THEOS_PLATFORM_MD5SUM := md5
_THEOS_PLATFORM_LIPO = xcrun lipo
THEOS_SUDO_COMMAND ?= sudo
_THEOS_PLATFORM_SHOW_IN_FILE_MANAGER := open -R
endif
```
