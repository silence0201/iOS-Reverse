#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/compiler-rt/lib/asan -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/compiler-rt/lib/asan/CMakeScripts/RTAsan_dynamic.osx_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
