//
//  MyPlugin.cpp
//  MyPlugin
//
//  Created by Silence on 2019/8/10.
//

#include <iostream>
#include <stdio.h>
#include <string>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <functional>
#include <vector>
#include "clang/AST/AST.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/ASTMatchers/ASTMatchers.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/FrontendPluginRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include "clang/Sema/Sema.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Basic/Diagnostic.h"
#include "clang/AST/DeclObjC.h"
#include "clang/Sema/Sema.h"

using namespace clang;
using namespace std;
using namespace llvm;
using namespace clang::ast_matchers;


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

namespace MyPlugin {
    static vector<string> split(const string &s, char delim){
        vector<string> elems;
        stringstream ss;
        ss.str(s);
        string item;
        while (getline(ss, item, delim)) {
            elems.push_back(item);
        }
        return elems;
    }
    
    // 语法树句柄
    class MyHandler : public MatchFinder::MatchCallback {
    private:
        CompilerInstance &ci;
        
        template <unsigned N>
        void diagWaringReport(SourceLocation Loc, const char (&FormatString)[N], FixItHint *Hint){
            DiagnosticsEngine &diagEngine = ci.getDiagnostics();
            unsigned DiagID = diagEngine.getCustomDiagID(clang::DiagnosticsEngine::Warning, FormatString);
            (Hint!=NULL) ? diagEngine.Report(Loc, DiagID) << *Hint : diagEngine.Report(Loc, DiagID);
        }
        
        bool isUserSourceCode(const Decl *decl) {
            string filename = ci.getSourceManager().getFilename(decl->getSourceRange().getBegin()).str();
            if (filename.empty()) return false;
            
            // 非Xcode中的源码都认为是用户源码
            if (filename.find("/Applications/Xcode.app/") == 0) return false;
            
            return true;
        }
        
        bool isShouldUseCopy(const string typeStr) {
            if (typeStr.find("NSString") != string::npos ||
                typeStr.find("NSArray") != string::npos ||
                typeStr.find("NSDictionary") != string::npos/*...*/) {
                return true;
            }
            return false;
        }
        
    public:
        MyHandler(CompilerInstance &ci) :ci(ci) {}
        
        // 检查类名的规范
        void checkInterfaceDecl(const ObjCInterfaceDecl *decl){
            // 获取类名
            StringRef className = decl->getName();
            char c = className[0];
            if (isLowercase(c)) {
                string tempName = className;
                cout << tempName << endl;
                tempName[0] = toUppercase(c);
                StringRef replacement(tempName);
                SourceLocation nameStart = decl->getLocation();
                SourceLocation nameEnd = nameStart.getLocWithOffset(className.size() - 1);
                //修复提示
                FixItHint fixItHint = FixItHint::CreateReplacement(SourceRange(nameStart, nameEnd), replacement);
                //警告错误提示
                DiagnosticsEngine &D = ci.getDiagnostics();
                int diagID = D.getCustomDiagID(DiagnosticsEngine::Warning, "MyPlugin: 类名不能以小写字母开头");
                SourceLocation location = decl->getLocation();
                D.Report(location, diagID).AddFixItHint(fixItHint);
            }
            //查找下划线位置
            size_t pos = decl->getName().find('_');
            if (pos != StringRef::npos) {
                DiagnosticsEngine &D = ci.getDiagnostics();
                SourceLocation loc = decl->getLocation().getLocWithOffset(pos);
                
                std::string tempName = className;
                std::string::iterator end_pos = std::remove(tempName.begin(), tempName.end(), '_');
                tempName.erase(end_pos, tempName.end());
                StringRef replacement(tempName);
                SourceLocation nameStart = decl->getLocation();
                SourceLocation nameEnd = nameStart.getLocWithOffset(className.size() - 1);
                FixItHint fixItHint = FixItHint::CreateReplacement(SourceRange(nameStart, nameEnd), replacement);
                
                int diagID = D.getCustomDiagID(DiagnosticsEngine::Warning, "MyPlugin: 类名中不能带有下划线");
                D.Report(loc, diagID).AddFixItHint(fixItHint);
            }
        }
        
        // 检查属性
        void checkPropertyDecl(const ObjCPropertyDecl *propertyDecl){
            if (propertyDecl) {
                ObjCPropertyDecl::PropertyAttributeKind attrKind = propertyDecl->getPropertyAttributes();
                string typeStr = propertyDecl->getType().getAsString();
                
                if (propertyDecl->getTypeSourceInfo() && isShouldUseCopy(typeStr) && !(attrKind & ObjCPropertyDecl::OBJC_PR_copy)) {
                    DiagnosticsEngine &diag = ci.getDiagnostics();
                    diag.Report(propertyDecl->getBeginLoc(), diag.getCustomDiagID(DiagnosticsEngine::Warning, "MyPlugin: %0 不是使用的 copy 修饰")) << typeStr;
                }
            }
        }
        
        // 检测属性名是否存在大写开头
        void checkPropertyNameForUppercaseName(const ObjCPropertyDecl *decl){
            bool checkUppercaseNameIndex = 0;
            StringRef name = decl -> getName();
            if (name.find('_') == 0)
            {
                //表示以下划线开头
                checkUppercaseNameIndex = 1;
            }
            //名称必须以小写字母开头
            char c = name[checkUppercaseNameIndex];
            if (isUppercase(c))
            {
                //修正提示
                std::string tempName = name;
                tempName[checkUppercaseNameIndex] = toLowercase(c);
                StringRef replacement(tempName);
                SourceLocation nameStart = decl->getLocation();
                SourceLocation nameEnd = nameStart.getLocWithOffset(name.size() - 1);
                FixItHint fixItHint = FixItHint::CreateReplacement(SourceRange(nameStart, nameEnd), replacement);
                //报告错误
                diagWaringReport(decl->getLocation(), "MyPlugin: 属性名称不能以大写开头", &fixItHint);
            }
        }
        
        // 检测属性名是否包含下划线
        void checkPropertyNameForUnderscoreInName(const ObjCPropertyDecl *decl){
            StringRef name = decl -> getName();
            
            if (name.size() == 1)
            {
                //不需要检测
                return;
            }
            
            //类名不能包含下划线
            size_t underscorePos = name.find('_', 1);
            if (underscorePos != StringRef::npos)
            {
                //修正提示
                std::string tempName = name;
                std::string::iterator end_pos = std::remove(tempName.begin() + 1, tempName.end(), '_');
                tempName.erase(end_pos, tempName.end());
                StringRef replacement(tempName);
                SourceLocation nameStart = decl->getLocation();
                SourceLocation nameEnd = nameStart.getLocWithOffset(name.size() - 1);
                FixItHint fixItHint = FixItHint::CreateReplacement(SourceRange(nameStart, nameEnd), replacement);
                //报告错误
                diagWaringReport(decl->getLocation(), "MyPlugin: 属性名字不允许有下划线", &fixItHint);
            }
        }
        
        // 检测委托属性是否有使用weak修饰
        void checkDelegatePropertyForUsageWeak (const ObjCPropertyDecl *decl){
            QualType type = decl -> getType();
            StringRef typeStr = type.getAsString();
            
            //Delegate
            if(typeStr.find("<") != string::npos && typeStr.find(">") != string::npos) {
                ObjCPropertyDecl::PropertyAttributeKind attrKind = decl -> getPropertyAttributes();
                
                if(!(attrKind & ObjCPropertyDecl::OBJC_PR_weak)){
                    diagWaringReport(decl -> getLocation(), "MyPlugin: 代理属性应该使用weak修饰", NULL);
                }
            }
        }
        
        // 检测方法名是否存在大写开头
        void checkMethodNameForUppercaseName(const ObjCMethodDecl *decl){
            //检查名称的每部分，都不允许以大写字母开头
            Selector sel = decl -> getSelector();
            int selectorPartCount = decl -> getNumSelectorLocs();
            for (int i = 0; i < selectorPartCount; i++)
            {
                StringRef selName = sel.getNameForSlot(i);
                char c = selName[0];
                if (isUppercase(c))
                {
                    //修正提示
                    std::string tempName = selName;
                    tempName[0] = toLowercase(c);
                    StringRef replacement(tempName);
                    SourceLocation nameStart = decl -> getSelectorLoc(i);
                    SourceLocation nameEnd = nameStart.getLocWithOffset(selName.size() - 1);
                    FixItHint fixItHint = FixItHint::CreateReplacement(SourceRange(nameStart, nameEnd), replacement);
                    diagWaringReport(decl->getLocation(), "MyPlugin: 方法名不应该以大写开头", &fixItHint);
                }
            }
        }
        
        // 检测方法实现是否超过50行代码
        void checkMethodBodyForOver50Lines(const ObjCMethodDecl *decl){
            if (decl -> hasBody())
            {
                //存在方法体
                Stmt *methodBody = decl -> getBody();
                
                string srcCode;
                srcCode.assign(ci.getSourceManager().getCharacterData(methodBody->getSourceRange().getBegin()),
                               methodBody->getSourceRange().getEnd().getRawEncoding() - methodBody->getSourceRange().getBegin().getRawEncoding() + 1);
                vector<string> lines = split(srcCode, '\n');
                if(lines.size() > 50){
                    diagWaringReport(decl -> getSourceRange().getBegin(), "MyPlugin: 单个方法内行数不能超过50行", NULL);
                }
            }
        }
        

        // 找到语法节点的回调
        void run(const MatchFinder::MatchResult &Result) {
            // 类的检测
            if (const ObjCInterfaceDecl *interfaceDecl = Result.Nodes.getNodeAs<ObjCInterfaceDecl>("ObjCInterfaceDecl")) {
                checkInterfaceDecl(interfaceDecl);
            }
            
            // 属性的检测
            if (const ObjCPropertyDecl *propertyDecl = Result.Nodes.getNodeAs<ObjCPropertyDecl>("ObjCPropertyDecl")) {
                // checkPropertyDecl(propertyDecl);
                checkPropertyNameForUppercaseName(propertyDecl);
                //checkPropertyNameForUnderscoreInName(propertyDecl);
                // checkDelegatePropertyForUsageWeak(propertyDecl);
            }
            
            // 方法的检测
            if (const ObjCMethodDecl *methodtDecl = Result.Nodes.getNodeAs<ObjCMethodDecl>("ObjCMethodDecl")) {
                checkMethodBodyForOver50Lines(methodtDecl);
                // checkMethodNameForUppercaseName(methodtDecl);
            }
        }
    };
    
    // 用于读取AST的抽象基类
    class MyASTConsumer: public ASTConsumer {
    private:
        MatchFinder matcher;
        MyHandler handler;
        
    public:
        MyASTConsumer(CompilerInstance &ci) :handler(ci) {
            //添加需要查找的语法树的节点，绑定标识，找到后的回调 handler 的run方法
            matcher.addMatcher(objcInterfaceDecl().bind("ObjCInterfaceDecl"), &handler);
            matcher.addMatcher(objcMethodDecl().bind("ObjCMethodDecl"), &handler);
            matcher.addMatcher(objcPropertyDecl().bind("ObjCPropertyDecl"), &handler);
        }
        
        // 当前的目标文件或源代码的AST被clang完整解析出来后才会回调
        // 遍历完一次语法树就会调用一次下面方法,context里面包含语法树的信息
        // This method is called when the ASTs for entire
        void HandleTranslationUnit(ASTContext &context) {
            // matcher查找语法树的节点
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

