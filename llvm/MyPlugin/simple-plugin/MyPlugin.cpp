#include <iostream>
#include "clang/AST/AST.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/ASTMatchers/ASTMatchers.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/FrontendPluginRegistry.h"

using namespace clang;
using namespace std;
using namespace llvm;
using namespace clang::ast_matchers;

namespace MyPlugin {
    
    /*
     -ObjCInterfaceDecl 0x7fbed1029d90 <<invalid sloc>> <invalid sloc> implicit Protocol
     |-TypedefDecl 0x7fbed102a0f8 <<invalid sloc>> <invalid sloc> implicit __NSConstantString 'struct __NSConstantString_tag'
     | `-RecordType 0x7fbed1029f00 'struct __NSConstantString_tag'
     |   `-Record 0x7fbed1029e60 '__NSConstantString_tag'
     |-TypedefDecl 0x7fbed102a190 <<invalid sloc>> <invalid sloc> implicit __builtin_ms_va_list 'char *'
     | `-PointerType 0x7fbed102a150 'char *'
     |   `-BuiltinType 0x7fbed1029580 'char'
     |-TypedefDecl 0x7fbed1062088 <<invalid sloc>> <invalid sloc> implicit __builtin_va_list 'struct __va_list_tag [1]'
     | `-ConstantArrayType 0x7fbed1062030 'struct __va_list_tag [1]' 1
     |   `-RecordType 0x7fbed1061ea0 'struct __va_list_tag'
     |     `-Record 0x7fbed1061e00 '__va_list_tag'
     |-ImportDecl 0x7fbed301b000 <./TestObj.h:9:1> col:1 implicit Foundation
     |-ObjCInterfaceDecl 0x7fbed3033140 <line:13:1, line:15:2> line:13:12 test_obj
     | |-super ObjCInterface 0x7fbed301b0f0 'NSObject'
     | `-ObjCImplementation 0x7fbed3033270 'test_obj'
     |-ObjCImplementationDecl 0x7fbed3033270 <TestObj.m:11:1, line:13:1> line:11:17 test_obj
     */
    
    // 语法树句柄
    class MyHandler : public MatchFinder::MatchCallback {
    private:
        CompilerInstance &ci;
        
    public:
        MyHandler(CompilerInstance &ci) :ci(ci) {}
        
        void run(const MatchFinder::MatchResult &Result) {
            if (const ObjCInterfaceDecl *decl = Result.Nodes.getNodeAs<ObjCInterfaceDecl>("ObjCInterfaceDecl")) {
                size_t pos = decl->getName().find('_');
                if (pos != StringRef::npos) {
                    DiagnosticsEngine &D = ci.getDiagnostics();
                    SourceLocation loc = decl->getLocation().getLocWithOffset(pos);
                    D.Report(loc, D.getCustomDiagID(DiagnosticsEngine::Error, "MyPlugin：类名中不能带有下划线"));
                }
            }
        }
    };
    
    // 语法树处理者
    class MyASTConsumer: public ASTConsumer {
    private:
        MatchFinder matcher;
        MyHandler handler;
        
    public:
        MyASTConsumer(CompilerInstance &ci) :handler(ci) {
            matcher.addMatcher(objcInterfaceDecl().bind("ObjCInterfaceDecl"), &handler);
        }
        
        // clang编译器编译完一个语法树后进行调用
        // This method is called when the ASTs for entire
        void HandleTranslationUnit(ASTContext &context) {
            matcher.matchAST(context);
        }
    };
    
    // 插件行为
    class MyASTAction: public PluginASTAction {
    public:
        // 讲语法树传给一个Consumer
        unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &ci, StringRef iFile) {
            return unique_ptr<MyASTConsumer> (new MyASTConsumer(ci));
        }
        
        bool ParseArgs(const CompilerInstance &ci, const vector<string> &args) {
            return true;
        }
    };
}

// 注册插件 [名称:描述]
static FrontendPluginRegistry::Add<MyPlugin::MyASTAction>
X("MyPlugin", "The MyPlugin is my first clang-plugin.");

