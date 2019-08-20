# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.benchmark.Debug:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Debug/libbenchmark.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Debug/libbenchmark.a


PostBuild.benchmark_main.Debug:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Debug/libbenchmark_main.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Debug/libbenchmark_main.a


PostBuild.benchmark.Release:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Release/libbenchmark.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Release/libbenchmark.a


PostBuild.benchmark_main.Release:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Release/libbenchmark_main.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/Release/libbenchmark_main.a


PostBuild.benchmark.MinSizeRel:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/MinSizeRel/libbenchmark.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/MinSizeRel/libbenchmark.a


PostBuild.benchmark_main.MinSizeRel:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/MinSizeRel/libbenchmark_main.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/MinSizeRel/libbenchmark_main.a


PostBuild.benchmark.RelWithDebInfo:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/RelWithDebInfo/libbenchmark.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/RelWithDebInfo/libbenchmark.a


PostBuild.benchmark_main.RelWithDebInfo:
/Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/RelWithDebInfo/libbenchmark_main.a:
	/bin/rm -f /Users/silence/Documents/Github/Me/iOS-Reverse/llvm/Source/llvm_xcode/lib/RelWithDebInfo/libbenchmark_main.a




# For each target create a dummy ruleso the target does not have to exist
