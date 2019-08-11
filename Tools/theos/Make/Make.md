# Theos Make结构分析

## Tweak的Makefile样例
```make
THEOS_DEVICE_IP = 192.168.0.112

ARCHS := armv7 armv7s arm64
SHARED_CFLAGS = -fobjc-arc
ADDITIONAL_OBJCFLAGS = -fobjc-arc

include theos/makefiles/common.mk

TWEAK_NAME = unlockscreen
unlockscreen_FILES = $(wildcard src/*.xm) $(wildcard src/*.m)

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard;exit;"

样例makefile文件编译名为unlockscreen的tweak插件，其中通过引用两个mk文件，导入theos的编译体系：

+ theos/makefiles/common.mk
+ include $(THEOS_MAKE_PATH)/tweak.mk
```

首先分析common.mk的实现。

## common.mk实现

+ Tweak工程变量定义  
```make
# 11-13行
THEOS_PROJECT_DIR ?= $(shell pwd)
_THEOS_LOCAL_DATA_DIR := $(THEOS_PROJECT_DIR)/.theos
_THEOS_BUILD_SESSION_FILE = $(_THEOS_LOCAL_DATA_DIR)/build_session
#分别当前tweak插件目录、缓存目录和编译会话文件。
```

+  Theos变量定义
```make
# 47
THEOS_MAKE_PATH := $(THEOS)/makefiles
THEOS_BIN_PATH := $(THEOS)/bin
THEOS_LIBRARY_PATH := $(THEOS)/lib
THEOS_INCLUDE_PATH := $(THEOS)/include
THEOS_FALLBACK_INCLUDE_PATH := $(THEOS)/include/_fallback
THEOS_MODULE_PATH := $(THEOS)/mod
#Theos环境变量； $(THEOS)为theos工程的绝对路径。
```  
从以下定义片段中，得到需要Tweak工程中配置的变量，<font color=FF4500>FOR_REALEASE</font>：  
	```make
	_THEOS_FINAL_PACKAGE := $(_THEOS_FALSE)

	ifeq ($(call __theos_bool,$(or $(FOR_RELEASE),$(FINALPACKAGE))),$(_THEOS_TRUE))
	_THEOS_FINAL_PACKAGE := $(_THEOS_TRUE)
	endif
	```  
FOR_RELEASE 通过Grep查找工程目录没有新的匹配处出现，所以是Tweak配置项，从名称上看，编译release版本时进行配置。  
+ Theos编译SCHEMA相关定义和生成：  
	```make  
	ifeq ($(THEOS_SCHEMA),)
	_THEOS_SCHEMA := $(shell echo "$(strip $(schema) $(SCHEMA))" | tr 'a-z' 'A-Z')
	_THEOS_ON_SCHEMA := DEFAULT $(filter-out -%,$(_THEOS_SCHEMA))

	ifeq ($(or $(debug),$(DEBUG))$(_THEOS_FINAL_PACKAGE),$(_THEOS_FALSE))
	DEBUG := 1
	endif
	ifeq ($(call __theos_bool,$(or $(debug),$(DEBUG))),$(_THEOS_TRUE))
	_THEOS_ON_SCHEMA += DEBUG
	endif

	#$(SCHEMA)未定义时，_THEOS_ON_SCHEMA生成完成 := DEFAULT DEBUG

	_THEOS_OFF_SCHEMA := $(patsubst -%,%,$(filter -%,$(_THEOS_SCHEMA)))

	override THEOS_SCHEMA := $(strip $(filter-out $(_THEOS_OFF_SCHEMA),$(_THEOS_ON_SCHEMA)))
	override _THEOS_CLEANED_SCHEMA_SET := $(shell echo "$(filter-out DEFAULT,$(THEOS_SCHEMA))" | tr -Cd ' A-Z' | tr ' A-Z' '_a-z')

	#生成 THOEOS_SCHEMA和
	export THEOS_SCHEMA _THEOS_CLEANED_SCHEMA_SET
	endif
	```
所有的SCHEMA族的定义有源头：<font color=FF4500>SCHEMA</font>，该定义可以由用户Tweak工程定义传入，因为同样在thoes项目中没有该变量定义。  
用户工程未定义改变量时，上述片段等同如下定义：  
	```make
	_THEOS_ON_SCHEMA:= DEFAULT DEBUG
	THOEOS_SCHEMA := DEFAULT DEBUG
	_THEOS_OFF_SCHEMA :=
	_THEOS_SCHEMA :=
	_THEOS_CLEANED_SCHEMA_SET := DEBUG
	```
几个函数，碰到时做具体展开  
	```make
	__schema_all_var_names = $(foreach sch,$(THEOS_SCHEMA),$(subst DEFAULT.,,$(sch).)$(1)$(2))  
	__schema_defined_var_names = $(foreach tuple,$(filter-out undefined:%,$(foreach schvar,$(call __schema_all_var_names,$(1),$(2)),$(origin $(schvar)):$(schvar))),$(lastword $(subst :, ,$(tuple))))
	__schema_var_all = $(strip $(foreach sch,$(call __schema_all_var_names,$(1),$(2)),$($(sch))))
	__schema_var_name_last = $(strip $(lastword $(call __schema_defined_var_names,$(1),$(2))))
	__schema_var_last = $(strip $($(lastword $(call __schema_defined_var_names,$(1),$(2)))))
	```  
当前工程目录是否存在layout目录：  
	```make
	ifeq ($(_THEOS_HAS_STAGING_LAYOUT),)
	_THEOS_HAS_STAGING_LAYOUT := $(call __exists,$(THEOS_PROJECT_DIR)/layout)
	endif

	```  
载入模块变量定义：
	```make
	_THEOS_LOAD_MODULES := $(sort $(call __schema_var_all,,MODULES) $(THEOS_AUTOLOAD_MODULES))
	__mod = -include $$(foreach mod,$$(_THEOS_LOAD_MODULES),$$(THEOS_MODULE_PATH)/$$(mod)/$(1))
	```
承上THEOS_SCHEMA定义的上下文，  
\__schema_var_all函数调用，$1 = '', $2='MODULES':  
首先调用__schema_all_var_names获取变量名称列表：MODULES DEBUG.MODULES;  
以上$(MODULES) $(DEBUG.MOUDLES)均为空;  
\_THEOS_LOAD_MODULES 为空；  

+ 完成以上变量定义后，导入legacy.mk文件  
```make
include $(THEOS_MAKE_PATH)/legacy.mk
```
legacy.mk 文件主要根据THEOS系列变量，定义出Framework系列变量; Framework系列变量使用递归定义，其中一部分在当前首次引入文件时theos未定义；

+ 系统环境相关变量定义  
	```make

	ifneq ($(_THEOS_PLATFORM_CALCULATED),1)
	uname_s := $(shell uname -s)
	uname_p := $(shell uname -p)
	uname_o := $(shell uname -o 2>/dev/null)

	ifeq ($(uname_s)-$(uname_p),Darwin-arm64)
	uname_p = arm
	endif

	export _THEOS_PLATFORM_ARCH = $(uname_s)-$(uname_p)
	export _THEOS_PLATFORM = $(uname_s)
	export _THEOS_OS = $(uname_o)

	ifeq ($(_THEOS_OS),)
	export _THEOS_OS = $(_THEOS_PLATFORM)
	endif

	export _THEOS_PLATFORM_CALCULATED := 1
	endif
	```
在当前MAC环境下，系统变量：  
```make
_THEOS_PLATFORM  := 'Darwin'
_THEOS_PLATFORM_ARCH  := 'Darwin-i386'
_THEOS_OS := 'Darwin'
_THEOS_PLATFORM_CALCULATED := 1
```
+ 导入系统相关的mk文件  
	```make
	-include $(THEOS_MAKE_PATH)/platform/$(_THEOS_PLATFORM_ARCH).mk
	-include $(THEOS_MAKE_PATH)/platform/$(_THEOS_OS).mk

	$(eval $(call __mod, platform/$(_THEOS_PLATFORM_ARCH).mk))
	$(eval $(call __mod, platform/$(_THEOS_OS).mk))
	```  
当前环境下导入文件：  
```make
# 首个文件不存在
-include $(THEOS_MAKE_PATH)/platform/Darwin-i386.mk
-include $(THEOS_MAKE_PATH)/platform/Darwin.mk
# __mod函数如前载入模块变量定义， null
```
platform对应的mk文件，在MacOS下为darwin.mk(platform_Darwin.md):  
	1. 设置du/md5命令;  
	2. 设置sdk环境变量:   
		1. 变量<font color=8a2be2>THEOS_PLATFORM_SDK_ROOT</font>；  
		2. 变量<font color=8a2be2>\_THEOS_PLATFORM_DEFAULT_TARGET</font>；  
		```make
		_THEOS_PLATFORM_DEFAULT_TARGET := iphone
		```
	3. 设置Theos系统平台变量。  
		```make
		THEOS_PLATFORM_NAME := macosx
		```
+ Target相关变量生成和配置  
	```make
	ifneq ($(_THEOS_TARGET_CALCULATED),1)
	__TARGET_MAKEFILE := $(shell $(THEOS_BIN_PATH)/target.pl "$(target)" "$(call __schema_var_last,,TARGET)" "$(_THEOS_PLATFORM_DEFAULT_TARGET)")
	-include $(__TARGET_MAKEFILE)
	$(shell rm -f $(__TARGET_MAKEFILE) > /dev/null 2>&1)
	export _THEOS_TARGET := $(__THEOS_TARGET_ARG_0)
	$(warning ostgt:$(_THEOS_TARGET), tgt:$(target), varlist:$(call __schema_var_last,,TARGET), target_makefile:$(__TARGET_MAKEFILE))
	ifeq ($(_THEOS_TARGET),)
	$(error You did not specify a target, and the "$(THEOS_PLATFORM_NAME)" platform does not define a default target)
	endif
	_THEOS_TARGET_CALCULATED := 1
	endif

	```
调用target.pl脚本生成\__TARGET_MAKEFILE变量和对应temp文件：  
参数：  
$1 := $(target)   ---> null  
$2 := ''       		---> null  
$3 := iphone  
该target.pl调用生成临时mk文件，导入变量<font color=8a2be2>\__THEOS_TARGET_ARG_0</font>：
```make
export __THEOS_TARGET_ARG_0 := iphone
```
随后<font color=8a2be2>\__THEOS_TARGET</font>赋值：
```make
export _THEOS_TARGET := $(__THEOS_TARGET_ARG_0)
```
如果$3 := iphone:clang 则target.pl生成的临时文件将导入:
```make
export __THEOS_TARGET_ARG_0 := iphone
export __THEOS_TARGET_ARG_1 := clang
```
通过<font color=8a2be2>\__THEOS_TARGET_ARG_1</font>的定义指定编译器，该设定在\$(\_THEOS_TARGET).mk(即iphone.mk)中生效。  
由上调用分析有两个用户工程配置变量为：
	1. <font color=ff4500>target</font>  
	2. <font color=ff4500>TARGET</font> 或 <font color=ff4500>DEBUG.TARGET</font>  
target.pl的处理，target定义优先级最高，其次是schema的TARGET族定义，最后未default定义;
将变量定义按照":"分割，分别存入\__THEOS_TARGET_ARG_(n)中。

+ 导入_THEOS_TARGET对应的mk文件  
```make
-include $(THEOS_MAKE_PATH)/targets/$(_THEOS_PLATFORM_ARCH)/$(_THEOS_TARGET).mk
-include $(THEOS_MAKE_PATH)/targets/$(_THEOS_PLATFORM)/$(_THEOS_TARGET).mk
-include $(THEOS_MAKE_PATH)/targets/$(_THEOS_OS)/$(_THEOS_TARGET).mk
-include $(THEOS_MAKE_PATH)/targets/$(_THEOS_TARGET).mk
```
其中只有targets/Darwin/iphone.mk文件存在，该文件根据上述生成的变量信息进行编译环境定义，是关键Make文件：  
	1. 编译器选择
	2. Target SDK版本
	3. 部署Deplayment IOS Version
	4. 编译命令和编译选项
	5. CFLAGS、LDFLAGS等编译选项初始化
	6. 安装包   
具体分解见文件targets_darwin_iphone.md。  
+ 编译配置  
	```make
	_THEOS_TARGET_NAME_DEFINE := $(shell echo "$(THEOS_TARGET_NAME)" | tr 'a-z' 'A-Z')

	export TARGET_CC TARGET_CXX TARGET_LD TARGET_STRIP TARGET_CODESIGN_ALLOCATE TARGET_CODESIGN TARGET_CODESIGN_FLAGS

	THEOS_TARGET_INCLUDE_PATH := $(THEOS_INCLUDE_PATH)/$(THEOS_TARGET_NAME)
	THEOS_TARGET_LIBRARY_PATH := $(THEOS_LIBRARY_PATH)/$(THEOS_TARGET_NAME)
	_THEOS_TARGET_HAS_INCLUDE_PATH := $(call __exists,$(THEOS_TARGET_INCLUDE_PATH))
	_THEOS_TARGET_HAS_LIBRARY_PATH := $(call __exists,$(THEOS_TARGET_LIBRARY_PATH))

	_THEOS_INTERNAL_LDFLAGS = $(if $(_THEOS_TARGET_HAS_LIBRARY_PATH),-L$(THEOS_TARGET_LIBRARY_PATH) )-L$(THEOS_LIBRARY_PATH)

	CFLAGS += -I$(THEOS_FALLBACK_INCLUDE_PATH)
	_THEOS_INTERNAL_CFLAGS = -DTARGET_$(_THEOS_TARGET_NAME_DEFINE)=1 $(OPTFLAG) -Wall
	_THEOS_INTERNAL_IFLAGS = $(if $(_THEOS_TARGET_HAS_INCLUDE_PATH),-I$(THEOS_TARGET_INCLUDE_PATH) )-I$(THEOS_INCLUDE_PATH) -include $(THEOS)/Prefix.pch
	_THEOS_INTERNAL_SWIFTFLAGS = -DTARGET_$(_THEOS_TARGET_NAME_DEFINE)=1 $(SWIFT_OPTFLAG) $(if $(_THEOS_TARGET_HAS_INCLUDE_PATH),-I$(THEOS_TARGET_INCLUDE_PATH) )-I$(THEOS_INCLUDE_PATH) -import-objc-header $(THEOS)/Prefix.pch -module-name $(THEOS_CURRENT_INSTANCE)
	ifneq ($(GO_EASY_ON_ME),1)
		_THEOS_INTERNAL_LOGOSFLAGS += -c warnings=error
		_THEOS_INTERNAL_CFLAGS += -Werror
	endif

	...
```

+ 目录环境配置
	```make
	THEOS_BUILD_DIR ?= .

	ifneq ($(_THEOS_CLEANED_SCHEMA_SET),)
	_THEOS_OBJ_DIR_EXTENSION = /$(_THEOS_CLEANED_SCHEMA_SET)
	endif

	ifneq ($(THEOS_TARGET_NAME),$(_THEOS_PLATFORM_DEFAULT_TARGET))
	THEOS_OBJ_DIR_NAME ?= obj/$(THEOS_TARGET_NAME)$(_THEOS_OBJ_DIR_EXTENSION)
	else
	THEOS_OBJ_DIR_NAME ?= obj$(_THEOS_OBJ_DIR_EXTENSION)
	endif
	ifeq ($(THEOS_CURRENT_ARCH),)
	THEOS_OBJ_DIR = $(_THEOS_LOCAL_DATA_DIR)/$(THEOS_OBJ_DIR_NAME)
	else
	THEOS_OBJ_DIR = $(_THEOS_LOCAL_DATA_DIR)/$(THEOS_OBJ_DIR_NAME)/$(THEOS_CURRENT_ARCH)
	endif

	THEOS_STAGING_DIR_NAME ?= _
	THEOS_STAGING_DIR = $(_THEOS_LOCAL_DATA_DIR)/$(THEOS_STAGING_DIR_NAME)
	_SPACE :=
	_SPACE +=
	_THEOS_ESCAPED_STAGING_DIR = $(subst $(_SPACE),\ ,$(THEOS_STAGING_DIR))

	THEOS_PACKAGE_DIR_NAME ?= debs
	THEOS_PACKAGE_DIR = $(THEOS_BUILD_DIR)/$(THEOS_PACKAGE_DIR_NAME)

	FW_PACKAGE_STAGING_DIR = $(THEOS_STAGING_DIR)$(warning FW_PACKAGE_STAGING_DIR is deprecated; please use THEOS_STAGING_DIR)

	```
+ 消息打印控制
```make
include $(THEOS_MAKE_PATH)/messages.mk
```
略。  
+ 引入staeg.mk和package.mk，见文件package.md分解。
```make
ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MAKE_PATH)/stage.mk
	include $(THEOS_MAKE_PATH)/package.mk
endif
```
至此，common.mk及关联的系列makefile文件分析告一段落。  


## tweak.mk系列文件分析  
+ 顶层tweak.mk文件  
在样例Makefile中引入文件$(THEOS_MAKE_PATH)/tweak.mk:  
```make
ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MAKE_PATH)/master/tweak.mk
else
	ifeq ($(_THEOS_CURRENT_TYPE),tweak)
		include $(THEOS_MAKE_PATH)/instance/tweak.mk
	endif
endif
```
完成common.mk系列makefile文件导入并未初始化变量THEOS_CURRENT_INSTANCE，所以首次引入该文件时，THEOS_CURRENT_INSTANCE值为空，因此首先导入$(THEOS_MAKE_PATH)/master/tweak.mk文件。  
+ master中的tweak.mk文件  
以下为master/tweak.mk文件：  
TWEAK_NAME初始定义于用户工程Makefile中，如样例makefile文件中；
```make
TWEAK_NAME := $(strip $(TWEAK_NAME))
```
引入rules.mk文件，  
```make
ifeq ($(_THEOS_RULES_LOADED),)
include $(THEOS_MAKE_PATH)/rules.mk
endif  
```
```make
internal-all:: $(TWEAK_NAME:=.all.tweak.variables);
internal-stage:: $(TWEAK_NAME:=.stage.tweak.variables);
```
<font color=ff4500>TWEAK_TARGET_PROCESS</font>由用户工程配置文件定义，在如下语句中添加到<font color=8a2be2>INSTALL_TARGET_PROCESSES</font>中，INSTALL_TARGET_PROCESSES变量在package.mk中被引用，在该deb安装完成后，变量指定值作为进程名执行killall命令。
```make
ifneq ($(TWEAK_TARGET_PROCESS),)
INSTALL_TARGET_PROCESSES += $(TWEAK_TARGET_PROCESS)
endif
```
包含子工程的Tweak项目变量生成：
```make
TWEAKS_WITH_SUBPROJECTS = $(strip $(foreach tweak,$(TWEAK_NAME),$(patsubst %,$(tweak),$(call __schema_var_all,$(tweak)_,SUBPROJECTS))))
ifneq ($(TWEAKS_WITH_SUBPROJECTS),)
internal-clean:: $(TWEAKS_WITH_SUBPROJECTS:=.clean.tweak.subprojects)
endif
```
如当前样例工程为例，会检查<font color=ff4500>unlockscreen_SUBPROJECTS</font>变量，如果该变量有定义，则unlockscreen会被包含在变量TWEAKS_WITH_SUBPROJECTS中。  

	当前tweak目标编译命令，重新以顶层makefiie启动make：
```make
$(TWEAK_NAME):
	@$(MAKE) -f $(_THEOS_PROJECT_MAKEFILE_NAME) --no-print-directory --no-keep-going $@.all.tweak.variables
$(eval $(call __mod,master/tweak.mk))
```
当前样例工程中，编译目标是：<font color=8a2be2>unlockscreen.tweak.variables</font>，根据该目标可在master/rules.mk文件中找到对应规则。

## rules.mk系列文件分析  
+ 顶层rules.mk文件  
在master/tweak.mk中引入顶层$(THEOS_MAKE_PATH)/rules.mk文件
```make
ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MAKE_PATH)/master/rules.mk
else
	include $(THEOS_MAKE_PATH)/instance/rules.mk
endif
```  
顶层rules.mk文件中，当前THEOS_CURRENT_INSTANCE未定义，首先引入master/rules.mk文件。  
完成master/rules.mk文件引入后，定义文件logos相关的文件处理规则:  
```make
%.mm: %.l.mm
	$(THEOS_BIN_PATH)/logos.pl $< > $@
%.mm: %.xmm
	$(THEOS_BIN_PATH)/logos.pl $< > $@
%.mm: %.xm
	$(THEOS_BIN_PATH)/logos.pl $< > $@
%.m: %.xm
	$(THEOS_BIN_PATH)/logos.pl $< > $@
%.swift: %.xswift
	$(THEOS_BIN_PATH)/logos.pl $< > $@
```
以及编译环境相关的目录创建规则：  
```make
$(THEOS_OBJ_DIR):
	@cd $(THEOS_BUILD_DIR); mkdir -p $(THEOS_OBJ_DIR_NAME)
$(THEOS_OBJ_DIR)/.stamp: $(THEOS_OBJ_DIR)
	@mkdir -p $(dir $@); touch $@
$(THEOS_OBJ_DIR)/%/.stamp: $(THEOS_OBJ_DIR)
	@mkdir -p $(dir $@); touch $@
	ifneq ($(THEOS_PACKAGE_DIR_NAME),)
$(THEOS_PACKAGE_DIR):
	@cd $(THEOS_BUILD_DIR); mkdir -p $(THEOS_PACKAGE_DIR_NAME)
endif
```
+ master中的rules.mk文件  
该文件为编译过程中的主要文件之一，详见master_rules.md文件中的分析。  
+ instance中的rules.mk文件  
该文件为编译过程最重要文件，详见instance_rules.md文件分析。
