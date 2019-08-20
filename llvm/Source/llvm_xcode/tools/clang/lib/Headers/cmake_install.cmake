# Install script for directory: /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang-resource-headersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/10.0.0/include" TYPE FILE FILES
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/adxintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/altivec.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ammintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/arm_acle.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/armintr.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/arm64intr.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx2intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512bf16intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512bwintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512bitalgintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlbitalgintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512cdintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vpopcntdqintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512dqintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512erintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512fintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512ifmaintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512ifmavlintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512pfintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vbmiintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vbmivlintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vbmi2intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlvbmi2intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlbf16intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlbwintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlcdintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vldqintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vp2intersectintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlvp2intersectintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vpopcntdqvlintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vnniintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avx512vlvnniintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/avxintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/bmi2intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/bmiintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_builtin_vars.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_cmath.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_complex_builtins.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_device_functions.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_intrinsics.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_libdevice_declares.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_math_forward_declares.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__clang_cuda_runtime_wrapper.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/cetintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/cldemoteintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/clzerointrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/cpuid.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/clflushoptintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/clwbintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/emmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/enqcmdintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/f16cintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/float.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/fma4intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/fmaintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/fxsrintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/gfniintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/htmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/htmxlintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ia32intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/immintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/inttypes.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/invpcidintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/iso646.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/limits.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/lwpintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/lzcntintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/mm3dnow.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/mmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/mm_malloc.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/module.modulemap"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/movdirintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/msa.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/mwaitxintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/nmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/opencl-c.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/opencl-c-base.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/pkuintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/pmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/pconfigintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/popcntintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/prfchwintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ptwriteintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/rdseedintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/rtmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/sgxintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/s390intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/shaintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/smmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stdalign.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stdarg.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stdatomic.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stdbool.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stddef.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__stddef_max_align_t.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stdint.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/stdnoreturn.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/tbmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/tgmath.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/tmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/unwind.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/vadefs.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/vaesintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/varargs.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/vecintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/vpclmulqdqintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/waitpkgintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/wbnoinvdintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/wmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__wmmintrin_aes.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/__wmmintrin_pclmul.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/x86intrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xopintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xsavecintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xsaveintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xsaveoptintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xsavesintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/xtestintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/tools/clang/lib/Headers/arm_neon.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/tools/clang/lib/Headers/arm_fp16.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang-resource-headersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/10.0.0/include/cuda_wrappers" TYPE FILE FILES
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/cuda_wrappers/algorithm"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/cuda_wrappers/complex"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/cuda_wrappers/new"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang-resource-headersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/10.0.0/include/ppc_wrappers" TYPE FILE FILES
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/mmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/xmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/mm_malloc.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/emmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/pmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/tmmintrin.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/ppc_wrappers/smmintrin.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xclang-resource-headersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/10.0.0/include/openmp_wrappers" TYPE FILE FILES
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/openmp_wrappers/math.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/openmp_wrappers/cmath"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/openmp_wrappers/__clang_openmp_math.h"
    "/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm/tools/clang/lib/Headers/openmp_wrappers/__clang_openmp_math_declares.h"
    )
endif()

