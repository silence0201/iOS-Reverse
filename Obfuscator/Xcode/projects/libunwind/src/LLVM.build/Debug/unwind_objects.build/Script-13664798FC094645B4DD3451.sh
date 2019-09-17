#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libunwind/src -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libunwind/src/CMakeScripts/unwind_objects_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
