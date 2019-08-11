
+ 编译器选择  
默认情况下， <font color=8a2be2>\__THEOS_TARGET_ARG_1</font>未定义，所以默认使用的时GCC编译器  
```make
ifeq ($(__THEOS_TARGET_ARG_1),clang)
_THEOS_TARGET_CC := clang
_THEOS_TARGET_CXX := clang++
_THEOS_TARGET_ARG_ORDER := 2 3
else
_THEOS_TARGET_CC := gcc
_THEOS_TARGET_CXX := g++
_THEOS_TARGET_ARG_ORDER := 1 2
endif
```

+ Target SDK版本  
```make
# A version specified as a target argument overrides all previous definitions.
_SDKVERSION := $(or $(__THEOS_TARGET_ARG_$(word 1,$(_THEOS_TARGET_ARG_ORDER))),$(SDKVERSION_$(THEOS_CURRENT_ARCH)),$(SDKVERSION))
_THEOS_TARGET_SDK_VERSION := $(or $(_SDKVERSION),latest)
_THEOS_TARGET_INCLUDE_SDK_VERSION := $(or $(INCLUDE_SDKVERSION),$(INCLUDE_SDKVERSION_$(THEOS_CURRENT_ARCH)),latest)
```
按照文起开头的用户Tweak的Makefile配置，完成上述语句时：
```make
_SDKVERSION =
_THEOS_TARGET_SDK_VERSION = lastest
_THEOS_TARGET_INCLUDE_SDK_VERSION = lastest
```
查找系统中存在的sdk版本，因为上述结果，以最新的sdk版本初始化值为lastest的变量：  
```make
_SDK_DIR := $(THEOS_PLATFORM_SDK_ROOT)/Platforms/iPhoneOS.platform/Developer/SDKs
_IOS_SDKS := $(sort $(patsubst $(_SDK_DIR)/iPhoneOS%.sdk,%,$(wildcard $(_SDK_DIR)/iPhoneOS*.sdk)))  
ifeq ($(words $(_IOS_SDKS)),0)
$(error You do not have an SDK in $(_SDK_DIR))
endif
_LATEST_SDK := $(lastword $(_IOS_SDKS))
ifeq ($(_THEOS_TARGET_SDK_VERSION),latest)
override _THEOS_TARGET_SDK_VERSION := $(_LATEST_SDK)
endif
ifeq ($(_THEOS_TARGET_INCLUDE_SDK_VERSION),latest)
override _THEOS_TARGET_INCLUDE_SDK_VERSION := $(_LATEST_SDK)
endif
```
当前开发环境下：  
```shell
➜  unlockscreen  ll /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs
total 8
drwxrwxr-t@ 8 see  admin   272B Oct 10 07:34 iPhoneOS.sdk
lrwxr-xr-x  1 see  admin    12B Oct 30 05:00 iPhoneOS9.1.sdk -> iPhoneOS.sdk
```  
两个变量:   
<font color=8a2be2>\_THEOS_TARGET_SDK_VERSION</font> := 9.1     
<font color=8a2be2>\_THEOS_TARGET_INCLSDK_VERSION</font> := 9.1  
上述描述可以得到SDKVERSION配置的几个来源，优先级依次：  
  1. \__THEOS_TARGET_ARG_1, 该配置值当前为空，不为空时，来源于用户工程配置的<font color=ff4500>TARGET</font>族变量；  
  2. SDKVERSION_$(ARCHS), 如<font color=ff4500>SDKVERSION_armv7  SDKVERSION_arm7s SDKVERSION_arm64</font>等；  
  3. 变量<font color=ff4500>SDKVERSION</font>定义。  

  以上编译目标SDK版本的相关设置。  

+ 部署Deplayment IOS Version   
```make
# We have to figure out the target version here, as we need it in the calculation of the deployment version.
_TARGET_VERSION_GE_8_4 = $(call __simplify,_TARGET_VERSION_GE_8_4,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 8.4))
_TARGET_VERSION_GE_7_0 = $(call __simplify,_TARGET_VERSION_GE_7_0,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 7.0))
_TARGET_VERSION_GE_6_0 = $(call __simplify,_TARGET_VERSION_GE_6_0,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 6.0))
_TARGET_VERSION_GE_3_0 = $(call __simplify,_TARGET_VERSION_GE_3_0,$(shell $(THEOS_BIN_PATH)/vercmp.pl $(_THEOS_TARGET_SDK_VERSION) ge 3.0))
ifeq ($(_TARGET_VERSION_GE_7_0),1)
_THEOS_TARGET_DEFAULT_IPHONEOS_DEPLOYMENT_VERSION := 5.0
else
ifeq ($(_TARGET_VERSION_GE_6_0),1)
_THEOS_TARGET_DEFAULT_IPHONEOS_DEPLOYMENT_VERSION := 4.3
else
_THEOS_TARGET_DEFAULT_IPHONEOS_DEPLOYMENT_VERSION := 3.0
endif
endif
_THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION := $(or $(__THEOS_TARGET_ARG_$(word 2,$(_THEOS_TARGET_ARG_ORDER))),$(TARGET_IPHONEOS_DEPLOYMENT_VERSION_$(THEOS_CURRENT_ARCH)),$(TARGET_IPHONEOS_DEPLOYMENT_VERSION),$(_SDKVERSION),$(_THEOS_TARGET_DEFAULT_IPHONEOS_DEPLOYMENT_VERSION))
ifeq ($(_THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION),latest)
override _THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION := $(_LATEST_SDK)
endif
```  
\_TARGET_VERSION_GE_8_4 := 1
所以_THEOS_TARGET_DEFAULT_IPHONEOS_DEPLOYMENT_VERSION := 5.0  
因其他高优先级的变量均未定义或为空，  
因此_THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION := 5.0，等同默认值；  
如果用户工程定义TARGET := iphone::6.0,  
则_THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION:=6.0 。  


+ 编译命令和编译选项  
根据Target SDK版本，初始化SDK库和头文件的路径信息
```make
ifeq ($(SYSROOT),)
SYSROOT ?= $(THEOS_PLATFORM_SDK_ROOT)/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS$(_THEOS_TARGET_SDK_VERSION).sdk
ISYSROOT ?= $(THEOS_PLATFORM_SDK_ROOT)/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS$(_THEOS_TARGET_INCLUDE_SDK_VERSION).sdk
else
ISYSROOT ?= $(SYSROOT)
endif
```  
编译命令相关变量初始化    
  ```make
  TARGET_CC ?= xcrun -sdk iphoneos $(_THEOS_TARGET_CC)
  TARGET_CXX ?= xcrun -sdk iphoneos $(_THEOS_TARGET_CXX)
  TARGET_SWIFT = xcrun -sdk iphoneos swift
  TARGET_LD ?= xcrun -sdk iphoneos $(_THEOS_TARGET_CXX)
  TARGET_STRIP ?= xcrun -sdk iphoneos strip
  TARGET_STRIP_FLAGS ?= -x
  TARGET_CODESIGN_ALLOCATE ?= "$(shell xcrun -sdk iphoneos -find codesign_allocate)"
  TARGET_CODESIGN ?= ldid
  TARGET_CODESIGN_FLAGS ?= -S

  TARGET_PRIVATE_FRAMEWORK_PATH = $(SYSROOT)/System/Library/PrivateFrameworks
  TARGET_PRIVATE_FRAMEWORK_INCLUDE_PATH = $(ISYSROOT)/System/Library/PrivateFrameworks

  include $(THEOS_MAKE_PATH)/targets/_common/darwin.mk
  include $(THEOS_MAKE_PATH)/targets/_common/darwin_flat_bundle.mk
  ```
  平台相关公共编译选项和变量  
  $(THEOS_MAKE_PATH)/targets/\_common/darwin.mk
  ```make
  TARGET_EXE_EXT :=
  TARGET_LIB_EXT := .dylib

  TARGET_LDFLAGS_DYNAMICLIB = -dynamiclib -install_name "$(LOCAL_INSTALL_PATH)/$(1)"
  TARGET_CFLAGS_DYNAMICLIB =

  _THEOS_TARGET_ONLY_OBJCFLAGS := -std=c99

  _THEOS_TARGET_SUPPORTS_BUNDLES := 1
  ```
  $(THEOS_MAKE_PATH)/targets/\_common/darwin_flat_bundle.mk，变量名称可猜用途，确切用途需到用时。
  ```make
  _THEOS_TARGET_BUNDLE_INFO_PLIST_SUBDIRECTORY :=
  _THEOS_TARGET_BUNDLE_RESOURCE_SUBDIRECTORY :=
  _THEOS_TARGET_BUNDLE_BINARY_SUBDIRECTORY :=
  ```  
  CPU体系相关初始化    
  ```make
  ifeq ($(_TARGET_VERSION_GE_7_0),1) # >= 7.0 {
	ARCHS ?= armv7 arm64
  else # } < 7.0 {
  ifeq ($(_TARGET_VERSION_GE_6_0),1) # >= 6.0 {
  ifeq ($(_TARGET_VERSION_GE_7_0)$(_DEPLOY_VERSION_GE_5_0),11) # >= 7.0, Deploy >= 5.0 {
  	ARCHS ?= armv7 arm64
  else # } else {
  	ARCHS ?= armv7
  endif # }
  else # } < 6.0 {
  ifeq ($(_TARGET_VERSION_GE_3_0),1) # >= 3.0 {
  	ARCHS ?= armv6 armv7
  else # } < 3.0 {
  	ARCHS ?= armv6
  endif # }
  endif # }
  endif # }
  NEUTRAL_ARCH = armv7
  ```  
  初始化两个变量:
    1. 变量<font color=ff4500>ARCHS</font>, 用户工程未定义时，当前初始化为ARCHS:=armv7 arm64;
    2. 变量NEUTRAL_ARCH = armv7  

+ CFLAGS、LDFLAGS等编译选项初始化  
  ```make
  ifeq ($(_TARGET_VERSION_GE_8_4),1)
  MODULESFLAGS := -fmodules -fcxx-modules -fmodule-name=$(THEOS_CURRENT_INSTANCE) -fbuild-session-file=$(_THEOS_BUILD_SESSION_FILE) -fmodules-prune-after=345600 -fmodules-prune-interval=86400 -fmodules-validate-once-per-build-session
  else
  MODULESFLAGS :=
  endif

  # “iOS 9 changed the 32-bit pagesize on 64-bit CPUs from 4096 bytes to 16384:
  # all 32-bit binaries must now be compiled with -Wl,-segalign,4000.”
  # https://twitter.com/saurik/status/654198997024796672

  ifeq ($(THEOS_CURRENT_ARCH),arm64)
  LEGACYFLAGS :=
  else
  LEGACYFLAGS := -Wl,-segalign,4000
  endif

  SDKFLAGS := -D__IPHONE_OS_VERSION_MIN_REQUIRED=__IPHONE_$(subst .,_,$(_THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION))
  VERSIONFLAGS := -miphoneos-version-min=$(_THEOS_TARGET_IPHONEOS_DEPLOYMENT_VERSION)

  _THEOS_TARGET_CFLAGS := -isysroot "$(ISYSROOT)" $(SDKFLAGS) $(VERSIONFLAGS) $(_THEOS_TARGET_CC_CFLAGS) $(MODULESFLAGS)
  _THEOS_TARGET_SWIFTFLAGS := -sdk "$(ISYSROOT)" $(SDKFLAGS) $(_THEOS_TARGET_CC_SWIFTFLAGS)
  _THEOS_TARGET_SWIFT_TARGET := apple-ios$(_THEOS_TARGET_SDK_VERSION)
  _THEOS_TARGET_SWIFT_LDPATH := $(THEOS_PLATFORM_SDK_ROOT)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphoneos
  _THEOS_TARGET_SWIFT_OBJPATH := $(THEOS_PLATFORM_SDK_ROOT)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift_static/iphoneos
  _THEOS_TARGET_SWIFT_VERSION := $(shell $(TARGET_SWIFT) --version | head -1 | cut -d' ' -f4)
  _THEOS_TARGET_LDFLAGS := -isysroot "$(SYSROOT)" $(SDKFLAGS) $(VERSIONFLAGS) $(LEGACYFLAGS) -multiply_defined suppress
  ```  

+ 安装包  
```make
TARGET_INSTALL_REMOTE := $(_THEOS_TRUE)
_THEOS_TARGET_DEFAULT_PACKAGE_FORMAT := deb
PREINSTALL_TARGET_PROCESSES ?= Cydia
```
