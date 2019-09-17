#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/tools/driver -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/clang/tools/driver/CMakeScripts/clang_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
