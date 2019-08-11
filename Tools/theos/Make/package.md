
+ 打包
```make
package:: internal-package-check stage before-package internal-package after-package
before-package:: $(THEOS_PACKAGE_DIR)
internal-package::
ifeq ($(_THEOS_FINAL_PACKAGE),$(_THEOS_TRUE))
	find $(THEOS_STAGING_DIR) -name \*.png -exec pincrush -i {} \;
	find $(THEOS_STAGING_DIR) \( -name \*.plist -or -name \*.strings \) -exec plutil -convert binary1 {} \;
endif
internal-package-check::
:	@:
# __THEOS_LAST_PACKAGE_FILENAME is to be set by a rule variable in the package format makefile.
after-package::
	@echo "$(__THEOS_LAST_PACKAGE_FILENAME)" > "$(_THEOS_LOCAL_DATA_DIR)/last_package"
```
<font color=8a2be2>stage</font> 为package的依赖目标。  
双冒号规则，多个规则可同时触发执行。  
通过：
```make
-include $(THEOS_MAKE_PATH)/package/$(_THEOS_PACKAGE_FORMAT).mk
```  
引入$(THEOS_MAKE_PATH)/package/deb.mk文件。
+ deb.mk 真正执行deb安装包生成的规则  
deb包生成三素, before-package阶段：
  1. control文件
  2. dpkg-deb执行文件
  3. stage目录，包含DEBIAN和layout文件夹  

  ```make
  before-package:: $(_THEOS_ESCAPED_STAGING_DIR)/DEBIAN/control
  ```
  ```make
  $(_THEOS_ESCAPED_STAGING_DIR)/DEBIAN/control: $(_THEOS_ESCAPED_STAGING_DIR)/DEBIAN
    $(ECHO_NOTHING)sed -e '/^[Vv]ersion:/d' "$(_THEOS_DEB_PACKAGE_CONTROL_PATH)" > "$@"$(ECHO_END)
    $(ECHO_NOTHING)echo "Version: $(_THEOS_INTERNAL_PACKAGE_VERSION)" >> "$@"$(ECHO_END)
    $(ECHO_NOTHING)echo "Installed-Size: $(shell $(_THEOS_PLATFORM_DU) $(_THEOS_PLATFORM_DU_EXCLUDE) DEBIAN -ks "$(THEOS_STAGING_DIR)" | cut -f 1)" >> "$@"$(ECHO_END)
  ```

  ```make
  $(_THEOS_ESCAPED_STAGING_DIR)/DEBIAN:
  	 $(ECHO_NOTHING)mkdir -p "$(THEOS_STAGING_DIR)/DEBIAN"$(ECHO_END)
     ifeq ($(_THEOS_HAS_STAGING_LAYOUT),1) # If we have a layout/ directory, copy layout/DEBIAN to the staging directory.
  	$(ECHO_NOTHING)[ -d "$(THEOS_PROJECT_DIR)/layout/DEBIAN" ] && rsync -a "$(THEOS_PROJECT_DIR)/layout/DEBIAN/" "$(THEOS_STAGING_DIR)/DEBIAN" $(_THEOS_RSYNC_EXCLUDE_COMMANDLINE) || true$(ECHO_END)
    endif
  ```
deb要素齐全后，执行打包命令：
```make
internal-package::
	$(ECHO_NOTHING)COPYFILE_DISABLE=1 $(FAKEROOT) -r $(_THEOS_PLATFORM_DPKG_DEB) -Zlzma -b "$(THEOS_STAGING_DIR)" "$(_THEOS_DEB_PACKAGE_FILENAME)" $(STDERR_NULL_REDIRECT)$(ECHO_END)
```
当前场景实际执行命令如：
```shell
dpkg-deb -Zlzma -b /Users/see/work/tmp/IOSDeviceDeb/unlockscreen/.theos/_ ./debs/com.bonree.unlockScreen_0.0.1-4+debug_iphoneos-arm.deb
```
完成打包后的after-package阶段：
```make
after-package:: __THEOS_LAST_PACKAGE_FILENAME = $(_THEOS_DEB_PACKAGE_FILENAME)
```
在package.md中将变量写入文件：
```make
after-package::
	@echo "$(__THEOS_LAST_PACKAGE_FILENAME)" > "$(_THEOS_LOCAL_DATA_DIR)/last_package"
```

+ deb包的版本生成规则  
<font color=ff4500>PACKAGE_VERSION</font> 用户定义版本信息，如果存在该变量的用户定义, 则deb版本<font color=8a2be2>\_THEOS_INTERNAL_PACKAGE_VERSION</font>直接使用该定义的版本号;
```make
#package.mk
$(eval __PACKAGE_VERSION = $$(call __simplify,__PACKAGE_VERSION,$(value $(call __schema_var_name_last,,PACKAGE_VERSION))))
override PACKAGE_VERSION = $(__PACKAGE_VERSION)
_THEOS_INTERNAL_PACKAGE_VERSION = $(call __simplify,_THEOS_INTERNAL_PACKAGE_VERSION,$(or $(__PACKAGE_VERSION),$(_THEOS_PACKAGE_DEFAULT_VERSION_FORMAT),1))
```
如果不存在该用户定义，则使用\_THEOS_PACKAGE_DEFAULT_VERSION_FORMAT的变量值;
```make
#package.mk
VERSION.EXTRAVERSION = $(if $(PACKAGE_BUILDNAME),+$(PACKAGE_BUILDNAME))
ifeq ($(_THEOS_FINAL_PACKAGE),$(_THEOS_TRUE))
VERSION.EXTRAVERSION = $(if $(PACKAGE_BUILDNAME),+$(PACKAGE_BUILDNAME))
_THEOS_PACKAGE_DEFAULT_VERSION_FORMAT = $(THEOS_PACKAGE_BASE_VERSION)$(VERSION.EXTRAVERSION)
else
VERSION.INC_BUILD_NUMBER = $(shell THEOS_PROJECT_DIR="$(THEOS_PROJECT_DIR)" "$(THEOS_BIN_PATH)/package_version.sh" -N "$(THEOS_PACKAGE_NAME)" -V "$(__BASEVER_FOR_BUILDNUM)")
_THEOS_PACKAGE_DEFAULT_VERSION_FORMAT = $(THEOS_PACKAGE_BASE_VERSION)-$(VERSION.INC_BUILD_NUMBER)$(VERSION.EXTRAVERSION)
endif
```
那么版本号可能有三部分组成：
  1. THEOS_PACKAGE_BASE_VERSION
  2. VERSION.EXTRAVERSION
  3. VERSION.INC_BUILD_NUMBER

  ```make
  #deb.mk
  THEOS_PACKAGE_BASE_VERSION := $(shell grep -i "^Version:" "$(_THEOS_DEB_PACKAGE_CONTROL_PATH)" | cut -d' ' -f2-)
  ```
VERSION.EXTRAVERSION来源于用户可定义变量<font color=ff4500>PACKAGE_BUILDNAME</font>；  
该变量在debug编译时，如用户未定义，则在common.mk中初始化:
```make
#common.mk
PACKAGE_BUILDNAME ?= debug
```
VERSION.INC_BUILD_NUMBER变量生成由$(THEOS_BIN_PATH)/package_version.sh通过-N和-V选项携带包名THEOS_PACKAGE_NAME和BASE版本信息\__BASEVER_FOR_BUILDNUM作为参数生成，该脚本在当前环境下通过.theos/package/$(TTHEOS_PACKAGE_NAME)-$(\__BASEVER_FOR_BUILDNUM)文件中版本号+1运算得到新版本号NUMBER。
```make
__USERVER_FOR_BUILDNUM := $(PACKAGE_VERSION)
__BASEVER_FOR_BUILDNUM = $(or $(__USERVER_FOR_BUILDNUM),$(THEOS_PACKAGE_BASE_VERSION))
```
综上，用户需要自定义的版本管理方式时，例如包含svn版本饿号，进行<font color=ff4500>PACKAGE_VERSION</font>变量定义就可以了。

+ 安装  
```make
#package.mk
install:: before-install internal-install after-install
```
安装包检查：
```make
internal-install-check::
	@if [ -z "$(_THEOS_PACKAGE_LAST_FILENAME)" ]; then \
		$(PRINT_FORMAT_ERROR) "$(MAKE) install and show require that you build a package before you try to install it." >&2; \
		exit 1; \
	fi
	@if [ ! -f "$(_THEOS_PACKAGE_LAST_FILENAME)" ]; then \
		$(PRINT_FORMAT_ERROR) "Could not find \"$(_THEOS_PACKAGE_LAST_FILENAME)\" to install. Aborting." >&2; \
		exit 1; \
	fi
```
安装环境变量
```make
export TARGET_INSTALL_REMOTE
_THEOS_INSTALL_TYPE := local
ifeq ($(TARGET_INSTALL_REMOTE),$(_THEOS_TRUE))
_THEOS_INSTALL_TYPE := remote
#略去无关语句
THEOS_DEVICE_PORT ?= 22
THEOS_DEVICE_USER ?= root
export THEOS_DEVICE_IP THEOS_DEVICE_PORT THEOS_DEVICE_USER
endif
```
以上，<font color=ff4500>THEOS_DEVICE_IP</font>必须在用户工程配置Makefile中定义，另外的用户名<font color=ff4500>THEOS_DEVICE_USER</font>和设备端口<font color=ff4500>THEOS_DEVICE_PORT</font>如果没有定义，则默认为root和22端口。    

  安装过程  
```make
install:: before-install internal-install after-install
after-install:: internal-after-install
before-install::
ifneq ($(PREINSTALL_TARGET_PROCESSES),)
	$(ECHO_PRE_UNLOADING)install.exec "killall $(PREINSTALL_TARGET_PROCESSES) 2>/dev/null || true"$(ECHO_END)
else
	@:
endif
internal-install::
	@:
internal-after-install::
ifneq ($(INSTALL_TARGET_PROCESSES),)
	$(ECHO_UNLOADING)install.exec "killall $(INSTALL_TARGET_PROCESSES) 2>/dev/null || true"$(ECHO_END)
else
	@:
endif
```  
引入另一个mk文件deb_remote.mk
```make
-include $(THEOS_MAKE_PATH)/install/$(_THEOS_PACKAGE_FORMAT)_$(_THEOS_INSTALL_TYPE).mk
```
deb_remote.mk文件中定义执行安装的具体命令：
```make
internal-install:: internal-install-check
	$(ECHO_INSTALLING)true$(ECHO_END)
	$(ECHO_NOTHING)install.exec "cat > /tmp/_theos_install.deb; $(_THEOS_SUDO_COMMAND) dpkg -i /tmp/_theos_install.deb && rm /tmp/_theos_install.deb" < "$(_THEOS_PACKAGE_LAST_FILENAME)"$(ECHO_END)
```  
install.exec是个shell脚本，里面命令简短如下：
```make
if [[ TARGET_INSTALL_REMOTE -eq 1 ]]; then
	exec ssh -p $THEOS_DEVICE_PORT $THEOS_DEVICE_USER@$THEOS_DEVICE_IP "$@"
else
	exec sh -c "$@"
fi
```
即远程连接后执行命令，该脚本可以改进增加密码交互能力。
