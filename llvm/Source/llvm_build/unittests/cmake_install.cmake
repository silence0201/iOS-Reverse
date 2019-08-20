# Install script for directory: /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/unittests

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

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/ADT/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Analysis/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/AsmParser/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/BinaryFormat/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Bitcode/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Bitstream/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/CodeGen/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/DebugInfo/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Demangle/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/ExecutionEngine/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/FuzzMutate/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/IR/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/LineEditor/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Linker/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/MC/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/MI/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Object/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/ObjectYAML/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Option/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Remarks/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Passes/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/ProfileData/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Support/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/TextAPI/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Target/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/Transforms/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/XRay/cmake_install.cmake")
  include("/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_build/unittests/tools/cmake_install.cmake")

endif()

