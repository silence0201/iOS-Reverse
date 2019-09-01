//
//  main.m
//  SimpleTest
//
//  Created by Silence on 2019/8/31.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

int sum(int a,int b) {
    return a + b;
}
/*
 SimpleTest`sum:
 0x100000ed0 <+0>:  pushq  %rbp
 0x100000ed1 <+1>:  movq   %rsp, %rbp
 0x100000ed4 <+4>:  movl   %edi, -0x4(%rbp)
 0x100000ed7 <+7>:  movl   %esi, -0x8(%rbp)
 0x100000eda <+10>: movl   -0x4(%rbp), %esi
 0x100000edd <+13>: addl   -0x8(%rbp), %esi
 0x100000ee0 <+16>: movl   %esi, %eax
 0x100000ee2 <+18>: popq   %rbp
 0x100000ee3 <+19>: retq
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a = 10;
        int b = 10;
        int c = a + b;
        int d = sum(a, b);
        /* 优先使用寄存器传参
         0x100000f22 <+50>:  movl   -0x14(%rbp), %edi
         0x100000f25 <+53>:  movl   -0x18(%rbp), %esi
         */
        NSLog(@"%d",c);
        NSLog(@"%d",d);
    }
    return 0;
}

/*
 SimpleTest`main:
 0x100000f10 <+0>:  pushq  %rbp
 0x100000f11 <+1>:  movq   %rsp, %rbp
 0x100000f14 <+4>:  subq   $0x30, %rsp
 0x100000f18 <+8>:  movl   $0x0, -0x4(%rbp)
 0x100000f1f <+15>: movl   %edi, -0x8(%rbp)
 0x100000f22 <+18>: movq   %rsi, -0x10(%rbp)
 0x100000f26 <+22>: callq  0x100000f7e               ; symbol stub for: objc_autoreleasePoolPush
 0x100000f2b <+27>: leaq   0xf6(%rip), %rsi          ; @"%d"
 0x100000f32 <+34>: movl   $0xa, -0x14(%rbp)     ; a = 10
 0x100000f39 <+41>: movl   $0xa, -0x18(%rbp)     ; b = 10
 0x100000f40 <+48>: movl   -0x14(%rbp), %edi
 0x100000f43 <+51>: addl   -0x18(%rbp), %edi
 0x100000f46 <+54>: movl   %edi, -0x1c(%rbp)  ; c = a + b
 0x100000f49 <+57>: movl   -0x1c(%rbp), %edi
 0x100000f4c <+60>: movl   %edi, -0x20(%rbp)
 0x100000f4f <+63>: movq   %rsi, %rdi
 0x100000f52 <+66>: movl   -0x20(%rbp), %esi
 0x100000f55 <+69>: movq   %rax, -0x28(%rbp)
 0x100000f59 <+73>: movb   $0x0, %al
 0x100000f5b <+75>: callq  0x100000f72               ; symbol stub for: NSLog
 0x100000f60 <+80>: movq   -0x28(%rbp), %rdi
 0x100000f64 <+84>: callq  0x100000f78               ; symbol stub for: objc_autoreleasePoolPop
 0x100000f69 <+89>: xorl   %eax, %eax
 0x100000f6b <+91>: addq   $0x30, %rsp
 0x100000f6f <+95>: popq   %rbp
 0x100000f70 <+96>: retq
 */
