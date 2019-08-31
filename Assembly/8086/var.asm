assume cs:code, ds:data, ss:stack

; 栈段
stack segment
    db 100 dup(0)
stack ends  

; 数据段
data segment  
    db 100 dup(0) 
data ends

; 代码段
code segment
start:
    ; 手动设置ds、ss的值
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax  
    
    ; 业务逻辑
    push 1
    push 2 
    call sum 
    add sp, 4 
     
    push 1
    push 2 
    call sum 
    add sp, 4   
    
    ; 退出
    mov ax, 4c00h
    int 21h 
    
; 返回值放ax寄存器
; 传递2个参数(放入栈中)    
sum:
    ; 保护bp    
    push bp
    ; 保存sp之前的值：指向bp以前的值
    mov bp, sp
    ; 预留10个字节的空间给局部变量 
    sub sp, 10  
    
    ; 定义2个局部变量
    mov word ptr ss:[bp-2], 3 
    mov word ptr ss:[bp-4], 4 
    mov ax, ss:[bp-2]
    add ax, ss:[bp-4]
    mov ss:[bp-6], ax
    
    ; 访问栈中的参数
    mov ax, ss:[bp+4]
    add ax, ss:[bp+6] 
    add ax, ss:[bp-6] `
                       
    ; 恢复sp
    mov sp, bp
    ; 恢复bp
    pop bp
    
    ret 
                
code ends  

end start

; 函数的调用流程（内存）
; 1.push 参数
; 2.push 函数的返回地址
; 3.push bp （保留bp之前的值，方便以后恢复）
; 4.mov bp, sp （保留sp之前的值，方便以后恢复）
; 5.sub sp,空间大小 （分配空间给局部变量）
; 6.执行业务逻辑
; 7.mov sp, bp （恢复sp之前的值）
; 8.pop bp （恢复bp之前的值）
; 9.ret （将函数的返回地址出栈，执行下一条指令）
; 10.恢复栈平衡 （add sp,参数所占的空间）