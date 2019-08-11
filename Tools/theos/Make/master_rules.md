
+ all系列编译目标  
```make
.PHONY: all before-all internal-all after-all \
	clean before-clean internal-clean after-clean update-theos
ifeq ($(THEOS_BUILD_DIR),.)
all:: $(_THEOS_BUILD_SESSION_FILE) before-all internal-all after-all
else
all:: $(THEOS_BUILD_DIR) $(_THEOS_BUILD_SESSION_FILE) before-all internal-all after-all
endif
```

+ 编译入口规则  
tweak.mk系列makefile文件的分析中，通过第一层递归make调用，当前样例工程使用如下规则编译目标：<font color=8a2be2>unlockscreen.all.tweak.variables</font>：
```make
%.variables: _INSTANCE = $(basename $(basename $*))
%.variables: _OPERATION = $(subst .,,$(suffix $(basename $*)))
%.variables: _TYPE = $(subst -,_,$(subst .,,$(suffix $*)))
%.variables: __SUBPROJECTS = $(strip $(call __schema_var_all,$(_INSTANCE)_,SUBPROJECTS))
%.variables:
	@ \
abs_build_dir=$(_THEOS_ABSOLUTE_BUILD_DIR); \
if [ "$(__SUBPROJECTS)" != "" ]; then \
  $(PRINT_FORMAT_MAKING) "Making $(_OPERATION) in subprojects of $(_TYPE) $(_INSTANCE)"; \
  for d in $(__SUBPROJECTS); do \
    d="$${d%:*}"; \
    if [ "$${abs_build_dir}" = "." ]; then \
      lbuilddir="."; \
    else \
      lbuilddir="$${abs_build_dir}/$$d"; \
    fi; \
    if $(MAKE) -C $$d -f $(_THEOS_PROJECT_MAKEFILE_NAME) $(_THEOS_NO_PRINT_DIRECTORY_FLAG) --no-keep-going $(_OPERATION) \
        THEOS_BUILD_DIR="$$lbuilddir" \
       ; then\
       :; \
    else exit $$?; \
    fi; \
  done; \
 fi; \
$(PRINT_FORMAT_MAKING) "Making $(_OPERATION) for $(_TYPE) $(_INSTANCE) - $*"; \
$(PRINT_FORMAT_MAKING) "Making $(_OPERATION) for $(_TYPE) $(_INSTANCE)"; \
$(MAKE) -f $(_THEOS_PROJECT_MAKEFILE_NAME) --no-print-directory --no-keep-going \
	internal-$(_TYPE)-$(_OPERATION) \
	_THEOS_CURRENT_TYPE="$(_TYPE)" \
	THEOS_CURRENT_INSTANCE="$(_INSTANCE)" \
	_THEOS_CURRENT_OPERATION="$(_OPERATION)" \
	THEOS_BUILD_DIR="$(_THEOS_ABSOLUTE_BUILD_DIR)"
```
当前样例工程中，以上规则实际执行：
```shell
abs_build_dir=.; \
if [ "" != "" ]; then \
  printf "\e[1;31m> \e[1;3;39m%s…\e[m\n" "Making all in subprojects of tweak unlockscreen"; \
  for d in ; do \
    d="${d%:*}"; \
    if [ "${abs_build_dir}" = "." ]; then \
      lbuilddir="."; \
    else \
      lbuilddir="${abs_build_dir}/$d"; \
    fi; \
    if /Applications/Xcode.app/Contents/Developer/usr/bin/make -C $d -f Makefile --no-print-directory --no-keep-going all \
        THEOS_BUILD_DIR="$lbuilddir" \
       ; then\
       :; \
    else exit $?; \
    fi; \
  done; \
 fi; \
printf "\e[1;31m> \e[1;3;39m%s…\e[m\n" "Making all for tweak unlockscreen"; \
/Applications/Xcode.app/Contents/Developer/usr/bin/make -f Makefile --no-print-directory --no-keep-going \
	internal-tweak-all \
	_THEOS_CURRENT_TYPE="tweak" \
	THEOS_CURRENT_INSTANCE="unlockscreen" \
	_THEOS_CURRENT_OPERATION="all" \
	THEOS_BUILD_DIR="."
```  
如上，通过第2层递归调用，编译目标为：<font color=8a2be2>internal-tweak-all</font>；同时，几个携带几个重要变量的赋值:  
  + 变量<font color=8a2be2>THEOS_CURRENT_INSTANCE</font> = "unlockscreen"
  + 变量<font color=8a2be2>\_THEOS_CURRENT_TYPE</font> = "tweak"
  + 变量<font color=8a2be2>\_THEOS_CURRENT_OPERATION</font> = "all"  
