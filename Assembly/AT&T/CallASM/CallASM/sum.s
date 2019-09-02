.global _sum

_sum:
    movq %rdi, %rax
    addq %rsi, %rax
    retq

