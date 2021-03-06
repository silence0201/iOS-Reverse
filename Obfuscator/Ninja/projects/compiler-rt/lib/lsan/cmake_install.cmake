# Install script for directory: /Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Source/projects/compiler-rt/lib/lsan

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Release")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "MinSizeRel")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang_rt.lsan_osx_dynamicx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin" TYPE SHARED_LIBRARY FILES "/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Build/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_osx_dynamic.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_osx_dynamic.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_osx_dynamic.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_osx_dynamic.dylib")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang_rt.lsan_osx_dynamicx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang_rt.lsan_iossim_dynamicx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin" TYPE SHARED_LIBRARY FILES "/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Build/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_iossim_dynamic.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_iossim_dynamic.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_iossim_dynamic.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_iossim_dynamic.dylib")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang_rt.lsan_iossim_dynamicx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang_rt.lsan_ios_dynamicx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin" TYPE SHARED_LIBRARY FILES "/Users/silence/Documents/Github/Me/iOS-Reverse/Obfuscator/Build/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_ios_dynamic.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_ios_dynamic.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_ios_dynamic.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/8.0.0/lib/darwin/libclang_rt.lsan_ios_dynamic.dylib")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang_rt.lsan_ios_dynamicx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

