#!/bin/sh
make -C /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/openmp/runtime/src -f /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/openmp/runtime/src/CMakeScripts/omp_postBuildPhase.make$CONFIGURATION OBJDIR=$(basename "$OBJECT_FILE_DIR_normal") all
