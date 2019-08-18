# add_llvm_loadable_module was removed in https://reviews.llvm.org/D51748
add_llvm_library(MyPlugin MODULE MyPlugin.cpp PLUGIN_TOOL clang)

if(LLVM_ENABLE_PLUGINS AND (WIN32 OR CYGWIN))
target_link_libraries(MyPlugin PRIVATE
clangAST
clangBasic
clangFrontend
LLVMSupport
)
endif()
