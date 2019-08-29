assume cs:code, ds:data

; 数据段
data segment
    db 11h,22h,'Hello World!$' 
data ends

; 代码段
code segment   
start:    
    ; 设置ds的值
    mov ax, data
    mov ds, ax  
    
    ; 
    mov dx, 2h
    mov ah, 9h
    int 21h

    ; 
    mov ax, 4c00h
    int 21h
code ends  

end start