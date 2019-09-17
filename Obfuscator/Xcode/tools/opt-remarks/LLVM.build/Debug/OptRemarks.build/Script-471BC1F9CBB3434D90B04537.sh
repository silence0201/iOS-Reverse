#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/opt-remarks -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/tools/opt-remarks/CMakeScripts/OptRemarks_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
