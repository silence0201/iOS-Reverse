#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libcxxabi/src -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libcxxabi/src/CMakeScripts/cxxabi_objects_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
