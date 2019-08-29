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
    
    ; 显示字符  DS:DX=串地址 '$'结束字符串
    mov dx, 2h
    mov ah, 9h
    int 21h

    ; 结束程序
    mov ah, 4ch
    int 21h
code ends  

end start