# Install script for directory: /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Tooling

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_release")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclangToolingx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/lib/libclangTooling.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclangTooling.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclangTooling.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libclangTooling.a")
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/tools/clang/lib/Tooling/Core/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/tools/clang/lib/Tooling/Inclusions/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/tools/clang/lib/Tooling/Refactoring/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/tools/clang/lib/Tooling/ASTDiff/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/tools/clang/lib/Tooling/Syntax/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/tools/clang/lib/Tooling/DependencyScanning/cmake_install.cmake")

endif()

