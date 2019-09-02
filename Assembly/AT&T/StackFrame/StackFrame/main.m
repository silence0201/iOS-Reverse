//
//  main.m
//  StackFrame
//
//  Created by Silence on 2019/9/2.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 StackFrame`sum:
 0x100000ef0 <+0>:  pushq  %rbp
 0x100000ef1 <+1>:  movq   %rsp, %rbp
 0x100000ef4 <+4>:  movl   %edi, -0x4(%rbp)
 0x100000ef7 <+7>:  movl   %esi, -0x8(%rbp)
 0x100000efa <+10>: movl   -0x4(%rbp), %esi
 0x100000efd <+13>: addl   -0x8(%rbp), %esi
 0x100000f00 <+16>: movl   %esi, -0xc(%rbp)
 0x100000f03 <+19>: movl   -0xc(%rbp), %esi
 0x100000f06 <+22>: addl   $0xa, %esi
 0x100000f09 <+25>: movl   %esi, -0x10(%rbp)
 0x100000f0c <+28>: movl   -0x10(%rbp), %eax
 0x100000f0f <+31>: popq   %rbp
 0x100000f10 <+32>: retq
 */

// 叶子函数:函数内部没有再调用其他函数
// 叶子函数不会减rsp来分配空间给局部变量
int sum(int a, int b) {
    int c = a + b;
    int d = c + 10;
    return d;
}


/*
 StackFrame`othersum:
 0x100000ec0 <+0>:  pushq  %rbp
 0x100000ec1 <+1>:  movq   %rsp, %rbp
 0x100000ec4 <+4>:  subq   $0x10, %rsp  ; sp上升16字节
 0x100000ec8 <+8>:  movl   $0x1, %eax
 0x100000ecd <+13>: movl   $0x2, %ecx
 0x100000ed2 <+18>: movl   %edi, -0x4(%rbp)
 0x100000ed5 <+21>: movl   %esi, -0x8(%rbp)
 0x100000ed8 <+24>: movl   %eax, %edi
 0x100000eda <+26>: movl   %ecx, %esi
 0x100000edc <+28>: callq  0x100000e90               ; sum at main.m:30
 0x100000ee1 <+33>: movl   %eax, -0xc(%rbp)
 0x100000ee4 <+36>: movl   -0xc(%rbp), %eax
 0x100000ee7 <+39>: addq   $0x10, %rsp ; 加回去
 0x100000eeb <+43>: popq   %rbp
 0x100000eec <+44>: retq
 */
int othersum (int a,int b) {
    int c = sum(1, 2);
    return c;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%d",sum(1, 2));
        NSLog(@"%d",othersum(1, 2));
    }
    return 0;
}
