	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 12, 1
	.globl	_simple                 ; -- Begin function simple
	.p2align	2
_simple:                                ; @simple
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	orr	w8, wzr, #0x3
	orr	w9, wzr, #0x2
	str	w9, [sp, #12]
	str	w8, [sp, #8]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_another                ; -- Begin function another
	.p2align	2
_another:                               ; @another
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32             ; =32
	stp	x29, x30, [sp, #16]     ; 8-byte Folded Spill
	add	x29, sp, #16            ; =16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #5
	orr	w9, wzr, #0x4
	stur	w9, [x29, #-4]
	str	w8, [sp, #8]
	bl	_simple
	ldp	x29, x30, [sp, #16]     ; 8-byte Folded Reload
	add	sp, sp, #32             ; =32
	ret
	.cfi_endproc
                                        ; -- End function

.subsections_via_symbols
