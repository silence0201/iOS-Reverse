//
//  main.m
//  IfElseTest
//
//  Created by Silence on 2019/9/1.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         0x100000e5b <+27>:  movl   $0x4, -0x14(%rbp)
         0x100000e62 <+34>:  cmpl   $0x1, -0x14(%rbp)
         0x100000e66 <+38>:  movq   %rax, -0x20(%rbp)
         0x100000e6a <+42>:  jne    0x100000e86               ; <+70> at main.m:16
         0x100000e70 <+48>:  leaq   0x1b1(%rip), %rax         ; @"'1'"
         0x100000e77 <+55>:  movq   %rax, %rdi
         0x100000e7a <+58>:  movb   $0x0, %al
         0x100000e7c <+60>:  callq  0x100000f62               ; symbol stub for: NSLog
         0x100000e81 <+65>:  jmp    0x100000f50               ; <+272> at main.m:29
         0x100000e86 <+70>:  cmpl   $0x2, -0x14(%rbp)
         0x100000e8a <+74>:  jne    0x100000ea6               ; <+102> at main.m:18
         0x100000e90 <+80>:  leaq   0x1b1(%rip), %rax         ; @"'2'"
         0x100000e97 <+87>:  movq   %rax, %rdi
         0x100000e9a <+90>:  movb   $0x0, %al
         0x100000e9c <+92>:  callq  0x100000f62               ; symbol stub for: NSLog
         0x100000ea1 <+97>:  jmp    0x100000f4b               ; <+267> at main.m
         0x100000ea6 <+102>: cmpl   $0x3, -0x14(%rbp)
         0x100000eaa <+106>: jne    0x100000ec6               ; <+134> at main.m:20
         0x100000eb0 <+112>: leaq   0x1b1(%rip), %rax         ; @"'3'"
         0x100000eb7 <+119>: movq   %rax, %rdi
         0x100000eba <+122>: movb   $0x0, %al
         0x100000ebc <+124>: callq  0x100000f62               ; symbol stub for: NSLog
         0x100000ec1 <+129>: jmp    0x100000f46               ; <+262> at main.m
         0x100000ec6 <+134>: cmpl   $0x4, -0x14(%rbp)
         0x100000eca <+138>: jne    0x100000ee6               ; <+166> at main.m:22
         0x100000ed0 <+144>: leaq   0x1b1(%rip), %rax         ; @"'4'"
         0x100000ed7 <+151>: movq   %rax, %rdi
         0x100000eda <+154>: movb   $0x0, %al
         0x100000edc <+156>: callq  0x100000f62               ; symbol stub for: NSLog
         0x100000ee1 <+161>: jmp    0x100000f41               ; <+257> at main.m
         0x100000ee6 <+166>: cmpl   $0x5, -0x14(%rbp)
         0x100000eea <+170>: jne    0x100000f06               ; <+198> at main.m:24
         0x100000ef0 <+176>: leaq   0x1b1(%rip), %rax         ; @"'5'"
         0x100000ef7 <+183>: movq   %rax, %rdi
         0x100000efa <+186>: movb   $0x0, %al
         0x100000efc <+188>: callq  0x100000f62               ; symbol stub for: NSLog
         0x100000f01 <+193>: jmp    0x100000f3c               ; <+252> at main.m
         0x100000f06 <+198>: cmpl   $0x6, -0x14(%rbp)
         0x100000f0a <+202>: jne    0x100000f26               ; <+230> at main.m
         0x100000f10 <+208>: leaq   0x1b1(%rip), %rax         ; @"'6'"
         0x100000f17 <+215>: movq   %rax, %rdi
         0x100000f1a <+218>: movb   $0x0, %al
         0x100000f1c <+220>: callq  0x100000f62               ; symbol stub for: NSLog
         0x100000f21 <+225>: jmp    0x100000f37               ; <+247> at main.m
         0x100000f26 <+230>: leaq   0x1bb(%rip), %rax         ; @"else"
         0x100000f2d <+237>: movq   %rax, %rdi
         0x100000f30 <+240>: movb   $0x0, %al
         0x100000f32 <+242>: callq  0x100000f62               ; symbol stub for: NSLog
         */
        int a = 4;
        /*
        if (a == 1) {
            NSLog(@"1");
        } else if (a == 2) {
            NSLog(@"2");
        } else if (a == 3) {
            NSLog(@"3");
        } else if (a == 4) {
            NSLog(@"4");
        } else if (a == 5) {
            NSLog(@"5");
        } else if (a == 6) {
            NSLog(@"6");
        } else {
            NSLog(@"else");
        }*/
        
        /*
         0x100000e6b <+27>:  movl   $0x4, -0x14(%rbp)
         0x100000e72 <+34>:  movl   -0x14(%rbp), %edi
         0x100000e75 <+37>:  decl   %edi
         0x100000e77 <+39>:  movl   %edi, %esi
         0x100000e79 <+41>:  subl   $0x5, %edi
         0x100000e7c <+44>:  movq   %rax, -0x20(%rbp)
         0x100000e80 <+48>:  movq   %rsi, -0x28(%rbp)
         0x100000e84 <+52>:  movl   %edi, -0x2c(%rbp)
         0x100000e87 <+55>:  ja     0x100000f25               ; <+213> at main.m
         0x100000e8d <+61>:  leaq   0xb4(%rip), %rax          ; main + 248
         0x100000e94 <+68>:  movq   -0x28(%rbp), %rcx
         0x100000e98 <+72>:  movslq (%rax,%rcx,4), %rdx
         0x100000e9c <+76>:  addq   %rax, %rdx
         0x100000e9f <+79>:  jmpq   *%rdx   ; 通过计算进行判断,如果判断条件比较多,用switch比较好
         0x100000ea1 <+81>:  leaq   0x180(%rip), %rax         ; @"'1'"
         0x100000ea8 <+88>:  movq   %rax, %rdi
         0x100000eab <+91>:  movb   $0x0, %al
         0x100000ead <+93>:  callq  0x100000f60               ; symbol stub for: NSLog
         0x100000eb2 <+98>:  jmp    0x100000f36               ; <+230> at main.m:104
         0x100000eb7 <+103>: leaq   0x18a(%rip), %rax         ; @"'2'"
         0x100000ebe <+110>: movq   %rax, %rdi
         0x100000ec1 <+113>: movb   $0x0, %al
         0x100000ec3 <+115>: callq  0x100000f60               ; symbol stub for: NSLog
         0x100000ec8 <+120>: jmp    0x100000f36               ; <+230> at main.m:104
         0x100000ecd <+125>: leaq   0x194(%rip), %rax         ; @"'3'"
         0x100000ed4 <+132>: movq   %rax, %rdi
         0x100000ed7 <+135>: movb   $0x0, %al
         0x100000ed9 <+137>: callq  0x100000f60               ; symbol stub for: NSLog
         0x100000ede <+142>: jmp    0x100000f36               ; <+230> at main.m:104
         0x100000ee3 <+147>: leaq   0x19e(%rip), %rax         ; @"'4'"
         0x100000eea <+154>: movq   %rax, %rdi
         0x100000eed <+157>: movb   $0x0, %al
         0x100000eef <+159>: callq  0x100000f60               ; symbol stub for: NSLog
         0x100000ef4 <+164>: jmp    0x100000f36               ; <+230> at main.m:104
         0x100000ef9 <+169>: leaq   0x1a8(%rip), %rax         ; @"'5'"
         0x100000f00 <+176>: movq   %rax, %rdi
         0x100000f03 <+179>: movb   $0x0, %al
         0x100000f05 <+181>: callq  0x100000f60               ; symbol stub for: NSLog
         0x100000f0a <+186>: jmp    0x100000f36               ; <+230> at main.m:104
         0x100000f0f <+191>: leaq   0x1b2(%rip), %rax         ; @"'6'"
         0x100000f16 <+198>: movq   %rax, %rdi
         0x100000f19 <+201>: movb   $0x0, %al
         0x100000f1b <+203>: callq  0x100000f60               ; symbol stub for: NSLog
         0x100000f20 <+208>: jmp    0x100000f36               ; <+230> at main.m:104
         0x100000f25 <+213>: leaq   0x1bc(%rip), %rax         ; @"else"
         0x100000f2c <+220>: movq   %rax, %rdi
         0x100000f2f <+223>: movb   $0x0, %al
         0x100000f31 <+225>: callq  0x100000f60               ; symbol stub for: NSLog
         */
        switch (a) {
            case 1:
                NSLog(@"1");
                break;
            case 2:
                NSLog(@"2");
                break;
            case 3:
                NSLog(@"3");
                break;
            case 4:
                NSLog(@"4");
                break;
            case 5:
                NSLog(@"5");
                break;
            case 6:
                NSLog(@"6");
                break;
            default:
                NSLog(@"else");
                break;
        }
    }
    return 0;
}
