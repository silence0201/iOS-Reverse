#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/tools/scan-build -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/tools/scan-build/CMakeScripts/scan-build_cmakeRulesBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
