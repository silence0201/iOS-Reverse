#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/include/clang/Driver -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/include/clang/Driver/CMakeScripts/ClangDriverOptions_cmakeRulesBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
