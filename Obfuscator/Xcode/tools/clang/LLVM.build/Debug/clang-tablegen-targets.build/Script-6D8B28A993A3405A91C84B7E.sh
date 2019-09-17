#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/CMakeScripts/clang-tablegen-targets_cmakeRulesBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
