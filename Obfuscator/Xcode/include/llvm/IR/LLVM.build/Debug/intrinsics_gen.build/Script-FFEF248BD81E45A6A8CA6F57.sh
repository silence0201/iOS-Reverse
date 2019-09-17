#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/include/llvm/IR -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/include/llvm/IR/CMakeScripts/intrinsics_gen_cmakeRulesBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
