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
    ; 初始化
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax  
    
    ;
    push 1122h
    push 3344h 
    call sum3 
    add sp, 4
    
    push 2222h
    push 2222h 
    call sum3
    add sp, 4
    
    push 3333h
    push 3333h 
    call sum3
    add sp, 4
     
    mov cx, 1122h 
    mov dx, 2233h 
    call sum1 
    
    mov word ptr [0], 1122h 
    mov word ptr [2], 2233h 
    call sum2  
    
    ; 
    mov ax, 4c00h
    int 21h 
    
; 使用栈传值  
sum3:   
    mov bp, sp
    mov ax, ss:[bp+2]
    add ax, ss:[bp+4]
    ret 

; 使用数据段传参      
sum2:         
    mov ax, [0]
    add ax, [2]
    ret 

; 参数分别放cx和dx中           
sum1:  
    mov ax, cx
    add ax, dx
    ret 
                
code ends  

end start