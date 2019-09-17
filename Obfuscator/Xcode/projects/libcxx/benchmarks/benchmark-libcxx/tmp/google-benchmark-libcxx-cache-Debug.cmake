
set(CMAKE_C_COMPILER "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang" CACHE STRING "Initial cache" FORCE)
set(CMAKE_CXX_COMPILER "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++" CACHE STRING "Initial cache" FORCE)
set(CMAKE_BUILD_TYPE "RELEASE" CACHE STRING "Initial cache" FORCE)
set(CMAKE_INSTALL_PREFIX "/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/projects/libcxx/benchmarks/benchmark-libcxx" CACHE PATH "Initial cache" FORCE)
set(CMAKE_CXX_FLAGS "-Wno-unused-command-line-argument -nostdinc++ -isystem /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Source/projects/libcxx/include -L/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)/lib -Wl,-rpath,/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Xcode/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)/lib -L -Wl,-rpath," CACHE STRING "Initial cache" FORCE)
set(BENCHMARK_USE_LIBCXX "ON" CACHE BOOL "Initial cache" FORCE)
set(BENCHMARK_ENABLE_TESTING "OFF" CACHE BOOL "Initial cache" FORCE)