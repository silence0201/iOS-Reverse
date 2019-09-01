//
//  main.m
//  CommandCodeTest
//
//  Created by Silence on 2019/9/1.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    /*
     0x100000f5f <+15>: movl   $0x4, %ecx
     0x100000f64 <+20>: movl   %ecx, %edx
     */
    NSLog(@"%lu",sizeof(int));
    
    int a = 1;
    /*
     -0x14(%rbp) => 局部变量a
     -0x18(%rbp) => 局部变量c
     
     %edx
     %r8d => a当前值
     
     0x100000f38 <+56>:  movl   $0x1, -0x14(%rbp) ; 局部变量a
     
     0x100000f3f <+63>:  movl   -0x14(%rbp), %ecx
     0x100000f42 <+66>:  movl   %ecx, %r8d
    
     0x100000f45 <+69>:  addl   $0x1, %r8d ; a++
     0x100000f49 <+73>:  movl   %r8d, -0x14(%rbp)
     0x100000f4d <+77>:  movl   -0x14(%rbp), %r8d
     
     0x100000f51 <+81>:  movl   %r8d, %r9d
     0x100000f54 <+84>:  addl   $0x1, %r9d
     0x100000f58 <+88>:  movl   %r9d, -0x14(%rbp)
     
     0x100000f5c <+92>:  addl   %r8d, %ecx
     0x100000f5f <+95>:  movl   -0x14(%rbp), %r8d
     0x100000f63 <+99>:  movl   %r8d, %r9d
     
     0x100000f66 <+102>: addl   $0x1, %r9d
     0x100000f6a <+106>: movl   %r9d, -0x14(%rbp)
     0x100000f6e <+110>: addl   %r8d, %ecx
     
     0x100000f71 <+113>: movl   %ecx, -0x18(%rbp) ; 局部变量c
     0x100000f74 <+116>: movl   -0x18(%rbp), %esi
     
     0x100000f77 <+119>: movq   %rdx, %rdi
     */
    int c = a++ + a++ + a++ ;
    NSLog(@"%d",c);
    
    return 0;
}
