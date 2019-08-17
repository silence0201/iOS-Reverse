
.text
.global _test
.global _add
.global _sub

; test函数实现
_test:
; mov指令
; mov x0, #0x8
; mov x1, x0

; add指令
; mov x0, #0x1
; mov x1, #0x2
; add x2, x0, x1

; sub指令
mov x0, #0x5
mov x1, #0x2
sub x2, x0, x1

ret

; add函数的实现
_add:
add x0, x0, x1
ret

; sub函数的实现
_sub:
sub x0, x0, x1
ret
