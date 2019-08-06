//
//  DladdrUtil.m
//  Testdladdr
//
//  Created by Silence on 2019/8/6.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "DladdrUtil.h"
#include <dlfcn.h>
#include <objc/runtime.h>

// Defines
static inline BOOL validate_methods(const char *,const char*) __attribute__((always_inline));
static inline void check_func(const char*,const char*)__attribute__((always_inline));

@implementation DladdrUtil

+ (void)simpleTest {
    check_func("NSArray", "description");
}

@end

void check_func(const char* cls,const char* sel) {
    Dl_info info;
    IMP imp = class_getMethodImplementation(objc_getClass(cls),
                                            sel_registerName(sel));
    printf("pointer %p\n",imp);
    if(dladdr(imp,&info)) {
        printf("dli_fname:%s\n",info.dli_fname);
        printf("dli_sname:%s\n",info.dli_sname);
    } else {
        printf("These symbols are not the symbols you're looking for.Bailing.\n");
    }
}

BOOL validate_methods(const char *cls,const char *fname){
    Class aClass = objc_getClass(cls);
    Method *methods;
    unsigned int nMethods;
    Dl_info info;
    IMP imp;
    char buf[128];
    Method m;
    
    if(!aClass)
        return NO;
    methods = class_copyMethodList(aClass, &nMethods);
    while (nMethods--) {
        m = methods[nMethods];
        printf("validating [%s %s]\n",(const char *)class_getName(aClass),(const char *)method_getName(m));
        
        imp = method_getImplementation(m);
        if(!imp){
            printf("error:method_getImplementation(%s) failed\n",(const char *)method_getName(m));
            free(methods);
            return NO;
        }
        
        if(!dladdr(imp, &info)){
            printf("error:dladdr() failed for %s\n",(const char *)method_getName(m));
            free(methods);
            return NO;
        }
        
        /*Validate image path*/
        if(strcmp(info.dli_fname, fname))
            goto FAIL;
        
        if (info.dli_sname != NULL && strcmp(info.dli_sname, "<redacted>") != 0) {
            /*Validate class name in symbol*/
            snprintf(buf, sizeof(buf), "[%s ",(const char *) class_getName(aClass));
            if(strncmp(info.dli_sname + 1, buf, strlen(buf))){
                snprintf(buf, sizeof(buf),"[%s(",(const char *)class_getName(aClass));
                if(strncmp(info.dli_sname + 1, buf, strlen(buf)))
                    goto FAIL;
            }
            
            /*Validate selector in symbol*/
            snprintf(buf, sizeof(buf), " %s]",(const char*)method_getName(m));
            if(strncmp(info.dli_sname + (strlen(info.dli_sname) - strlen(buf)), buf, strlen(buf))){
                goto FAIL;
            }
        }else{
            printf("<redacted>  \n");
        }
        
    }
    
    return YES;
    
FAIL:
    printf("method %s failed integrity test:\n",
           (const char *)method_getName(m));
    printf("    dli_fname:%s\n",info.dli_fname);
    printf("    dli_sname:%s\n",info.dli_sname);
    printf("    dli_fbase:%p\n",info.dli_fbase);
    printf("    dli_saddr:%p\n",info.dli_saddr);
    free(methods);
    return NO;
}
