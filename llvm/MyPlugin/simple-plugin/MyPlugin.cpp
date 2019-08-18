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

