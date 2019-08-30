assume cs:code, ds:data, ss:stack

; 栈段
stack segment   
    db 10 dup(8)
stack ends 

; 数据段
data segment   
    db 20 dup(9)
data ends 

; 代码段
code segment
start: 
    ; 手动设置栈段和数据段
    mov ax, stack
    mov ss, ax   
    mov ax, data
    mov ds, ax

    mov ax, 1122h
    mov bx, 3344h  
    
    mov [0], ax
    
    mov sp, 10 
    push ax
    push bx
    pop ax
    pop bx
    
    
    ; 结束程序
    mov ax, 4c00h
    int 21h   
code ends

end start