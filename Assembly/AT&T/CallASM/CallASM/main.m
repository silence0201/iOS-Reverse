//
//  main.m
//  CallASM
//
//  Created by Silence on 2019/9/2.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sum.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int c = sum(10, 20);
        NSLog(@"%d",c);
        
        int a = 10;
        int b = 20;
        int result;
        
        __asm__(
                "addq %%rbx, %%rax"
                : "=a"(result)
                : "a"(a), "b"(b)
                );
        
        NSLog(@"%d", result);
    }
    return 0;
}
