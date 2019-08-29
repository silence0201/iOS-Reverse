assume cs:code

code segment  
    db 55h, 66h, 77h, 88h
    db 10 dup(0) 
    db 'Hello World!'

start:         
    mov ax, cs:[0]
    mov bx, cs:[2]
    mov ch, age
    
    mov ax, 4c00h
    int 21h
code ends

; 程序入口在start
end start