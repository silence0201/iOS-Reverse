; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=sse2 | FileCheck %s

; Note: This test is testing that the lowering for atomics matches what we
; currently emit for non-atomics + the atomic restriction.  The presence of
; particular lowering detail in these tests should not be read as requiring
; that detail for correctness unless it's related to the atomicity itself.
; (Specifically, there were reviewer questions about the lowering for halfs
;  and their calling convention which remain unresolved.)

define void @store_half(half* %fptr, half %v) {
; CHECK-LABEL: store_half:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    callq __gnu_f2h_ieee
; CHECK-NEXT:    movw %ax, (%rbx)
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  store atomic half %v, half* %fptr unordered, align 2
  ret void
}

define void @store_float(float* %fptr, float %v) {
; CHECK-LABEL: store_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    movl %eax, (%rdi)
; CHECK-NEXT:    retq
  store atomic float %v, float* %fptr unordered, align 4
  ret void
}

define void @store_double(double* %fptr, double %v) {
; CHECK-LABEL: store_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %xmm0, %rax
; CHECK-NEXT:    movq %rax, (%rdi)
; CHECK-NEXT:    retq
  store atomic double %v, double* %fptr unordered, align 8
  ret void
}

define void @store_fp128(fp128* %fptr, fp128 %v) {
; CHECK-LABEL: store_fp128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    callq __sync_lock_test_and_set_16
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  store atomic fp128 %v, fp128* %fptr unordered, align 16
  ret void
}

define half @load_half(half* %fptr) {
; CHECK-LABEL: load_half:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movzwl (%rdi), %eax
; CHECK-NEXT:    movzwl %ax, %edi
; CHECK-NEXT:    callq __gnu_h2f_ieee
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %v = load atomic half, half* %fptr unordered, align 2
  ret half %v
}

define float @load_float(float* %fptr) {
; CHECK-LABEL: load_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    retq
  %v = load atomic float, float* %fptr unordered, align 4
  ret float %v
}

define double @load_double(double* %fptr) {
; CHECK-LABEL: load_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq %rax, %xmm0
; CHECK-NEXT:    retq
  %v = load atomic double, double* %fptr unordered, align 8
  ret double %v
}

define fp128 @load_fp128(fp128* %fptr) {
; CHECK-LABEL: load_fp128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    xorl %r8d, %r8d
; CHECK-NEXT:    callq __sync_val_compare_and_swap_16
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %v = load atomic fp128, fp128* %fptr unordered, align 16
  ret fp128 %v
}


; sanity check the seq_cst lowering since that's the
; interesting one from an ordering perspective on x86.

define void @store_float_seq_cst(float* %fptr, float %v) {
; CHECK-LABEL: store_float_seq_cst:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xchgl %eax, (%rdi)
; CHECK-NEXT:    retq
  store atomic float %v, float* %fptr seq_cst, align 4
  ret void
}

define void @store_double_seq_cst(double* %fptr, double %v) {
; CHECK-LABEL: store_double_seq_cst:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %xmm0, %rax
; CHECK-NEXT:    xchgq %rax, (%rdi)
; CHECK-NEXT:    retq
  store atomic double %v, double* %fptr seq_cst, align 8
  ret void
}

define float @load_float_seq_cst(float* %fptr) {
; CHECK-LABEL: load_float_seq_cst:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    retq
  %v = load atomic float, float* %fptr seq_cst, align 4
  ret float %v
}

define double @load_double_seq_cst(double* %fptr) {
; CHECK-LABEL: load_double_seq_cst:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq %rax, %xmm0
; CHECK-NEXT:    retq
  %v = load atomic double, double* %fptr seq_cst, align 8
  ret double %v
}