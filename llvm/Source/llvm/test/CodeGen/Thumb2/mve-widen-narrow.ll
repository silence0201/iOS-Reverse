; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-arm-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-LE
; RUN: llc -mtriple=thumbebv8.1m.main-arm-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-BE

define void @foo_int8_int32(<4 x i8>* %dest, <4 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int8_int32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vstrb.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i32>, <4 x i32>* %src, align 4
  %0 = trunc <4 x i32> %wide.load to <4 x i8>
  store <4 x i8> %0, <4 x i8>* %dest, align 1
  ret void
}

define void @foo_int16_int32(<4 x i16>* %dest, <4 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vstrh.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i32>, <4 x i32>* %src, align 4
  %0 = trunc <4 x i32> %wide.load to <4 x i16>
  store <4 x i16> %0, <4 x i16>* %dest, align 2
  ret void
}

define void @foo_int8_int16(<8 x i8>* %dest, <8 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int8_int16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q0, [r1]
; CHECK-NEXT:    vstrb.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i16>, <8 x i16>* %src, align 2
  %0 = trunc <8 x i16> %wide.load to <8 x i8>
  store <8 x i8> %0, <8 x i8>* %dest, align 1
  ret void
}

define void @foo_int32_int8(<4 x i32>* %dest, <4 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i8>, <4 x i8>* %src, align 1
  %0 = sext <4 x i8> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_int16_int8(<8 x i16>* %dest, <8 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s16 q0, [r1]
; CHECK-NEXT:    vstrh.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i8>, <8 x i8>* %src, align 1
  %0 = sext <8 x i8> %wide.load to <8 x i16>
  store <8 x i16> %0, <8 x i16>* %dest, align 2
  ret void
}

define void @foo_int32_int16(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 2
  %0 = sext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_uint32_uint8(<4 x i32>* %dest, <4 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i8>, <4 x i8>* %src, align 1
  %0 = zext <4 x i8> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_uint16_uint8(<8 x i16>* %dest, <8 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint16_uint8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q0, [r1]
; CHECK-NEXT:    vstrh.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i8>, <8 x i8>* %src, align 1
  %0 = zext <8 x i8> %wide.load to <8 x i16>
  store <8 x i16> %0, <8 x i16>* %dest, align 2
  ret void
}

define void @foo_uint32_uint16(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 2
  %0 = zext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}




define void @foo_int16_int32_align1(<4 x i16>* %dest, <4 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int32_align1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .pad #8
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    mov r1, sp
; CHECK-NEXT:    vstrh.32 q0, [r1]
; CHECK-NEXT:    ldrd r1, r2, [sp]
; CHECK-NEXT:    str r1, [r0]
; CHECK-NEXT:    str r2, [r0, #4]
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i32>, <4 x i32>* %src, align 4
  %0 = trunc <4 x i32> %wide.load to <4 x i16>
  store <4 x i16> %0, <4 x i16>* %dest, align 1
  ret void
}

define void @foo_int32_int16_align1(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int16_align1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .pad #8
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    ldr r2, [r1]
; CHECK-NEXT:    ldr r1, [r1, #4]
; CHECK-NEXT:    strd r2, r1, [sp]
; CHECK-NEXT:    mov r1, sp
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 1
  %0 = sext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_uint32_uint16_align1(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16_align1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .pad #8
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    ldr r2, [r1]
; CHECK-NEXT:    ldr r1, [r1, #4]
; CHECK-NEXT:    strd r2, r1, [sp]
; CHECK-NEXT:    mov r1, sp
; CHECK-NEXT:    vldrh.u32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 1
  %0 = zext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}