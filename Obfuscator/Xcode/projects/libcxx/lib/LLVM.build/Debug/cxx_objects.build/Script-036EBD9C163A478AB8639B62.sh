#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libcxx/lib -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libcxx/lib/CMakeScripts/cxx_objects_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
