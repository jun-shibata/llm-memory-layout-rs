	.build_version macos, 26, 0	sdk_version 26, 5
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	stp	d9, d8, [sp, #-112]!            ; 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	sub	sp, sp, #2800
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
Lloh0:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh2:
	ldr	x8, [x8]
	stur	x8, [x29, #-120]
	cmp	w0, #8
	b.ne	LBB0_132
; %bb.1:
	mov	x19, x1
	ldr	x0, [x1, #8]
Ltmp6:                                  ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
Ltmp7:                                  ; EH_LABEL
; %bb.2:
	mov	x26, x0
	ldr	x0, [x19, #16]
Ltmp9:                                  ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
Ltmp10:                                 ; EH_LABEL
; %bb.3:
	mov	x27, x0
	ldr	x0, [x19, #24]
Ltmp12:                                 ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
Ltmp13:                                 ; EH_LABEL
; %bb.4:
	mov	x28, x0
	ldr	x0, [x19, #32]
Ltmp15:                                 ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
Ltmp16:                                 ; EH_LABEL
; %bb.5:
	mov	x24, x0
	ldr	x0, [x19, #40]
Ltmp18:                                 ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
	str	x0, [sp, #40]                   ; 8-byte Spill
Ltmp19:                                 ; EH_LABEL
; %bb.6:
	ldr	x0, [x19, #48]
Ltmp21:                                 ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
Ltmp22:                                 ; EH_LABEL
; %bb.7:
	mov	x22, x0
	ldr	x0, [x19, #56]
Ltmp24:                                 ; EH_LABEL
	bl	__ZZ4mainENK3$_0clEPKc
	str	x0, [sp, #80]                   ; 8-byte Spill
Ltmp25:                                 ; EH_LABEL
; %bb.8:
	cmp	x24, x27
	b.hs	LBB0_134
; %bb.9:
	cbz	x26, LBB0_134
; %bb.10:
	cbz	x27, LBB0_134
; %bb.11:
	cbz	x28, LBB0_134
; %bb.12:
	ldr	x8, [sp, #40]                   ; 8-byte Reload
	cbz	x8, LBB0_134
; %bb.13:
	cbz	x22, LBB0_134
; %bb.14:
	umulh	x8, x27, x26
	cmp	xzr, x8
	b.ne	LBB0_131
; %bb.15:
	mul	x8, x27, x26
	umulh	x9, x28, x8
	cmp	xzr, x9
	b.ne	LBB0_131
; %bb.16:
	mul	x21, x28, x8
	lsr	x8, x21, #62
	cbnz	x8, LBB0_131
; %bb.17:
	lsr	x8, x28, #62
	cbnz	x8, LBB0_136
; %bb.18:
	lsl	x23, x28, #2
Ltmp29:                                 ; EH_LABEL
	mov	x0, x23
	bl	__Znwm
Ltmp30:                                 ; EH_LABEL
; %bb.19:
	mov	x20, x0
	mov	x1, x23
	bl	_bzero
	cbz	x21, LBB0_121
; %bb.20:
	lsl	x19, x21, #2
Ltmp31:                                 ; EH_LABEL
	mov	x0, x19
	bl	__Znwm
Ltmp32:                                 ; EH_LABEL
; %bb.21:
	mov	x25, x0
	add	x8, x0, x21, lsl #2
	str	x8, [sp, #16]                   ; 8-byte Spill
	mov	x1, x19
	bl	_bzero
Ltmp34:                                 ; EH_LABEL
	mov	x0, x19
	bl	__Znwm
Ltmp35:                                 ; EH_LABEL
; %bb.22:
	add	x8, x0, x21, lsl #2
	str	x8, [sp, #8]                    ; 8-byte Spill
	str	x0, [sp, #56]                   ; 8-byte Spill
	mov	x1, x19
	bl	_bzero
Ltmp37:                                 ; EH_LABEL
	mov	x0, x19
	bl	__Znwm
Ltmp38:                                 ; EH_LABEL
; %bb.23:
	add	x8, x0, x21, lsl #2
	str	x8, [sp]                        ; 8-byte Spill
	str	x0, [sp, #48]                   ; 8-byte Spill
	mov	x1, x19
	bl	_bzero
	str	x25, [sp, #64]                  ; 8-byte Spill
	str	x23, [sp, #104]                 ; 8-byte Spill
	lsr	x8, x26, #62
	cbnz	x8, LBB0_122
LBB0_24:
	lsl	x19, x26, #2
Ltmp40:                                 ; EH_LABEL
	mov	x0, x19
	bl	__Znwm
Ltmp41:                                 ; EH_LABEL
; %bb.25:
	mov	x25, x0
	str	x19, [sp, #32]                  ; 8-byte Spill
	mov	x1, x19
	bl	_bzero
	ldr	x11, [sp, #80]                  ; 8-byte Reload
	str	w11, [sp, #136]
	mov	w8, #1                          ; =0x1
	mov	w9, #35173                      ; =0x8965
	movk	w9, #27655, lsl #16
	add	x10, sp, #136
                                        ; kill: def $w11 killed $w11 killed $x11
LBB0_26:                                ; =>This Inner Loop Header: Depth=1
	eor	w11, w11, w11, lsr #30
	madd	w11, w11, w9, w8
	str	w11, [x10, x8, lsl #2]
	add	x8, x8, #1
	cmp	x8, #624
	b.ne	LBB0_26
; %bb.27:
	str	x22, [sp, #96]                  ; 8-byte Spill
	mov	x13, #0                         ; =0x0
	mov	x12, #0                         ; =0x0
	mov	w8, #-272236544                 ; =0xefc60000
	mov	w9, #22144                      ; =0x5680
	movk	w9, #40236, lsl #16
	mov	w10, #45279                     ; =0xb0df
	movk	w10, #39176, lsl #16
	add	x14, sp, #136
	mov	x11, #3361                      ; =0xd21
	movk	x11, #8402, lsl #16
	movk	x11, #53773, lsl #32
	movk	x11, #3360, lsl #48
	fmov	s0, #-1.00000000
	mov	w15, #624                       ; =0x270
	ldr	x4, [sp, #104]                  ; 8-byte Reload
LBB0_28:                                ; =>This Inner Loop Header: Depth=1
	mov	x16, x12
	add	x12, x12, #1
	cmp	x12, #624
	csinc	x12, xzr, x16, eq
	ldr	w17, [x14, x16, lsl #2]
	ldr	w0, [x14, x12, lsl #2]
	and	w17, w17, #0x80000000
	and	w1, w0, #0x7ffffffe
	add	x2, x16, #397
	lsr	x3, x2, #4
	umulh	x3, x3, x11
	lsr	x3, x3, #1
	orr	w17, w1, w17
	msub	x1, x3, x15, x2
	ldr	w1, [x14, x1, lsl #2]
	tst	w0, #0x1
	csel	w0, w10, wzr, ne
	eor	w0, w0, w1
	eor	w17, w0, w17, lsr #1
	eor	w0, w17, w17, lsr #11
	and	w1, w9, w0, lsl #7
	eor	w0, w1, w0
	and	w1, w8, w0, lsl #15
	eor	w0, w1, w0
	lsr	w1, w0, #26
	eor	w0, w1, w0, lsr #8
	ucvtf	s1, w0, #23
	str	w17, [x14, x16, lsl #2]
	fadd	s1, s1, s0
	str	s1, [x20, x13]
	add	x13, x13, #4
	cmp	x4, x13
	b.ne	LBB0_28
; %bb.29:
	mov	x14, #0                         ; =0x0
	lsl	x13, x27, #2
	mul	x15, x26, x27
	lsl	x15, x15, #2
	mul	x16, x27, x28
	lsl	x22, x16, #2
	mul	x16, x26, x28
	lsl	x16, x16, #2
	mov	w17, #624                       ; =0x270
	add	x0, sp, #136
	fmov	s0, #-1.00000000
	ldp	x1, x2, [sp, #56]               ; 16-byte Folded Reload
	ldr	x3, [sp, #48]                   ; 8-byte Reload
	stp	x13, x22, [sp, #112]            ; 16-byte Folded Spill
LBB0_30:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_31 Depth 2
                                        ;       Child Loop BB0_32 Depth 3
	str	x14, [sp, #128]                 ; 8-byte Spill
	mov	x4, #0                          ; =0x0
	mov	x5, x1
	mov	x6, x2
	mov	x7, x3
LBB0_31:                                ;   Parent Loop BB0_30 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_32 Depth 3
	mov	x22, #0                         ; =0x0
	mov	x23, x7
LBB0_32:                                ;   Parent Loop BB0_30 Depth=1
                                        ;     Parent Loop BB0_31 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x30, x12
	add	x12, x12, #1
	lsr	x21, x12, #4
	umulh	x21, x21, x11
	lsr	x21, x21, #1
	msub	x12, x21, x17, x12
	ldr	w21, [x0, x30, lsl #2]
	and	w21, w21, #0x80000000
	ldr	w14, [x0, x12, lsl #2]
	and	w19, w14, #0x7ffffffe
	orr	w19, w19, w21
	add	x21, x30, #397
	lsr	x13, x21, #4
	umulh	x13, x13, x11
	lsr	x13, x13, #1
	msub	x13, x13, x17, x21
	ldr	w13, [x0, x13, lsl #2]
	tst	w14, #0x1
	csel	w14, w10, wzr, ne
	eor	w13, w14, w13
	eor	w13, w13, w19, lsr #1
	str	w13, [x0, x30, lsl #2]
	eor	w13, w13, w13, lsr #11
	and	w14, w9, w13, lsl #7
	eor	w13, w14, w13
	and	w14, w8, w13, lsl #15
	eor	w13, w14, w13
	lsr	w14, w13, #26
	eor	w13, w14, w13, lsr #8
	ucvtf	s1, w13, #23
	fadd	s1, s1, s0
	str	s1, [x6, x22, lsl #2]
	str	s1, [x5, x22, lsl #2]
	str	s1, [x23]
	add	x22, x22, #1
	add	x23, x23, x15
	cmp	x28, x22
	b.ne	LBB0_32
; %bb.33:                               ;   in Loop: Header=BB0_31 Depth=2
	add	x4, x4, #1
	add	x7, x7, #4
	ldr	x13, [sp, #104]                 ; 8-byte Reload
	add	x6, x6, x13
	add	x5, x5, x16
	cmp	x4, x27
	b.ne	LBB0_31
; %bb.34:                               ;   in Loop: Header=BB0_30 Depth=1
	ldp	x22, x14, [sp, #120]            ; 16-byte Folded Reload
	add	x14, x14, #1
	ldr	x13, [sp, #112]                 ; 8-byte Reload
	add	x3, x3, x13
	add	x2, x2, x22
	ldr	x13, [sp, #104]                 ; 8-byte Reload
	add	x1, x1, x13
	cmp	x14, x26
	b.ne	LBB0_30
; %bb.35:
	str	x12, [sp, #2632]
	lsr	x8, x26, #61
	cbnz	x8, LBB0_137
; %bb.36:
	lsl	x19, x26, #3
Ltmp42:                                 ; EH_LABEL
	mov	x0, x19
	bl	__Znwm
Ltmp43:                                 ; EH_LABEL
; %bb.37:
	mov	x21, x0
	str	x19, [sp, #24]                  ; 8-byte Spill
	mov	x1, x19
	bl	_bzero
	mov	x8, #0                          ; =0x0
	mul	x9, x24, x28
	ldr	x10, [sp, #64]                  ; 8-byte Reload
	add	x9, x10, x9, lsl #2
	str	x21, [sp, #72]                  ; 8-byte Spill
LBB0_38:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_39 Depth 2
	mov	x10, #0                         ; =0x0
	ldr	d0, [x21, x8, lsl #3]
LBB0_39:                                ;   Parent Loop BB0_38 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s1, [x20, x10, lsl #2]
	fcvt	d1, s1
	ldr	s2, [x9, x10, lsl #2]
	fcvt	d2, s2
	fmadd	d0, d1, d2, d0
	add	x10, x10, #1
	cmp	x28, x10
	b.ne	LBB0_39
; %bb.40:                               ;   in Loop: Header=BB0_38 Depth=1
	ldr	x21, [sp, #72]                  ; 8-byte Reload
	str	d0, [x21, x8, lsl #3]
	add	x8, x8, #1
	add	x9, x9, x22
	cmp	x8, x26
	b.ne	LBB0_38
; %bb.41:
	ldp	x8, x1, [sp, #56]               ; 16-byte Folded Reload
	stp	x1, x8, [x29, #-144]
	ldr	x8, [sp, #48]                   ; 8-byte Reload
	stur	x8, [x29, #-128]
	mov	x0, x20
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	bl	__Z3dotIL6Layout0EEvPKfS2_Pfmmmm
	mov	x8, #0                          ; =0x0
	movi.2d	v0, #0000000000000000
	mov	w9, #2139095039                 ; =0x7f7fffff
	mov	x10, #17197                     ; =0x432d
	movk	x10, #60188, lsl #16
	movk	x10, #14050, lsl #32
	movk	x10, #16154, lsl #48
	fmov	d1, x10
LBB0_42:                                ; =>This Inner Loop Header: Depth=1
	ldr	s3, [x25, x8, lsl #2]
	fcvt	d4, s3
	ldr	x10, [sp, #72]                  ; 8-byte Reload
	ldr	d2, [x10, x8, lsl #3]
	fmov	w10, s3
	fabd	d3, d4, d2
	fcmp	d0, d3
	fcsel	d0, d3, d0, mi
	and	w10, w10, #0x7fffffff
	cmp	w10, w9
	b.gt	LBB0_123
; %bb.43:                               ;   in Loop: Header=BB0_42 Depth=1
	fabs	d2, d2
	fmadd	d2, d2, d1, d1
	fcmp	d3, d2
	b.gt	LBB0_123
; %bb.44:                               ;   in Loop: Header=BB0_42 Depth=1
	add	x8, x8, #1
	cmp	x26, x8
	b.ne	LBB0_42
; %bb.45:
	stur	d0, [x29, #-168]
	mov	x0, x20
	ldr	x1, [sp, #56]                   ; 8-byte Reload
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	bl	__Z3dotIL6Layout1EEvPKfS2_Pfmmmm
	mov	x9, #0                          ; =0x0
	sub	x8, x29, #168
	add	x8, x8, #8
	movi.2d	v0, #0000000000000000
	mov	w22, #1                         ; =0x1
	mov	w10, #2139095039                ; =0x7f7fffff
	mov	x11, #17197                     ; =0x432d
	movk	x11, #60188, lsl #16
	movk	x11, #14050, lsl #32
	movk	x11, #16154, lsl #48
	fmov	d1, x11
LBB0_46:                                ; =>This Inner Loop Header: Depth=1
	ldr	s3, [x25, x9, lsl #2]
	fcvt	d4, s3
	ldr	x11, [sp, #72]                  ; 8-byte Reload
	ldr	d2, [x11, x9, lsl #3]
	fmov	w11, s3
	fabd	d3, d4, d2
	fcmp	d0, d3
	fcsel	d0, d3, d0, mi
	and	w11, w11, #0x7fffffff
	cmp	w11, w10
	b.gt	LBB0_124
; %bb.47:                               ;   in Loop: Header=BB0_46 Depth=1
	fabs	d2, d2
	fmadd	d2, d2, d1, d1
	fcmp	d3, d2
	b.gt	LBB0_124
; %bb.48:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x9, x9, #1
	cmp	x26, x9
	b.ne	LBB0_46
; %bb.49:
	stur	d0, [x29, #-160]
	mov	x0, x20
	ldr	x1, [sp, #48]                   ; 8-byte Reload
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	bl	__Z3dotIL6Layout2EEvPKfS2_Pfmmmm
	mov	x9, #0                          ; =0x0
	sub	x8, x29, #168
	add	x8, x8, #16
	movi.2d	v0, #0000000000000000
	mov	w22, #2                         ; =0x2
	mov	w10, #2139095039                ; =0x7f7fffff
	mov	x11, #17197                     ; =0x432d
	movk	x11, #60188, lsl #16
	movk	x11, #14050, lsl #32
	movk	x11, #16154, lsl #48
	fmov	d1, x11
LBB0_50:                                ; =>This Inner Loop Header: Depth=1
	ldr	s3, [x25, x9, lsl #2]
	fcvt	d4, s3
	ldr	x11, [sp, #72]                  ; 8-byte Reload
	ldr	d2, [x11, x9, lsl #3]
	fmov	w11, s3
	fabd	d3, d4, d2
	fcmp	d0, d3
	fcsel	d0, d3, d0, mi
	and	w11, w11, #0x7fffffff
	cmp	w11, w10
	b.gt	LBB0_124
; %bb.51:                               ;   in Loop: Header=BB0_50 Depth=1
	fabs	d2, d2
	fmadd	d2, d2, d1, d1
	fcmp	d3, d2
	b.gt	LBB0_124
; %bb.52:                               ;   in Loop: Header=BB0_50 Depth=1
	add	x9, x9, #1
	cmp	x26, x9
	b.ne	LBB0_50
; %bb.53:
	stur	d0, [x29, #-152]
Lloh3:
	adrp	x8, l___const.main.iterations@PAGE
Lloh4:
	add	x8, x8, l___const.main.iterations@PAGEOFF
Lloh5:
	ldr	q0, [x8]
	sub	x8, x29, #256
	str	q0, [x8, #64]
	mov	w21, #1                         ; =0x1
	stur	x21, [x29, #-176]
	ldr	x8, [sp, #96]                   ; 8-byte Reload
	ucvtf	d0, x8
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmul	d8, d0, d1
LBB0_54:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_55 Depth 2
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	mov	x19, x0
	mov	x22, x21
	ldr	x23, [sp, #64]                  ; 8-byte Reload
LBB0_55:                                ;   Parent Loop BB0_54 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x0, x20
	mov	x1, x23
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	bl	__Z3dotIL6Layout0EEvPKfS2_Pfmmmm
	; InlineAsm Start
	; InlineAsm End
	subs	x22, x22, #1
	b.ne	LBB0_55
; %bb.56:                               ;   in Loop: Header=BB0_54 Depth=1
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	sub	x8, x0, x19
	scvtf	d0, x8
	fcmp	d8, d0
	b.le	LBB0_59
; %bb.57:                               ;   in Loop: Header=BB0_54 Depth=1
	tbnz	x21, #63, LBB0_128
; %bb.58:                               ;   in Loop: Header=BB0_54 Depth=1
	lsl	x21, x21, #1
	b	LBB0_54
LBB0_59:
	stur	x21, [x29, #-192]
	sub	x8, x29, #192
	orr	x8, x8, #0x8
	str	x8, [sp, #128]                  ; 8-byte Spill
	mov	w21, #1                         ; =0x1
LBB0_60:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_61 Depth 2
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	mov	x19, x0
	mov	x23, x21
	ldr	x22, [sp, #56]                  ; 8-byte Reload
LBB0_61:                                ;   Parent Loop BB0_60 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x0, x20
	mov	x1, x22
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	bl	__Z3dotIL6Layout1EEvPKfS2_Pfmmmm
	; InlineAsm Start
	; InlineAsm End
	subs	x23, x23, #1
	b.ne	LBB0_61
; %bb.62:                               ;   in Loop: Header=BB0_60 Depth=1
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	sub	x8, x0, x19
	scvtf	d0, x8
	fcmp	d8, d0
	b.le	LBB0_65
; %bb.63:                               ;   in Loop: Header=BB0_60 Depth=1
	tbnz	x21, #63, LBB0_129
; %bb.64:                               ;   in Loop: Header=BB0_60 Depth=1
	lsl	x21, x21, #1
	b	LBB0_60
LBB0_65:
	stur	x21, [x29, #-184]
	sub	x8, x29, #192
	add	x8, x8, #16
	str	x8, [sp, #128]                  ; 8-byte Spill
	mov	w21, #1                         ; =0x1
LBB0_66:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_67 Depth 2
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	mov	x19, x0
	mov	x23, x21
	ldr	x22, [sp, #48]                  ; 8-byte Reload
LBB0_67:                                ;   Parent Loop BB0_66 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x0, x20
	mov	x1, x22
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	bl	__Z3dotIL6Layout2EEvPKfS2_Pfmmmm
	; InlineAsm Start
	; InlineAsm End
	subs	x23, x23, #1
	b.ne	LBB0_67
; %bb.68:                               ;   in Loop: Header=BB0_66 Depth=1
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	sub	x8, x0, x19
	scvtf	d0, x8
	fcmp	d8, d0
	b.le	LBB0_71
; %bb.69:                               ;   in Loop: Header=BB0_66 Depth=1
	tbnz	x21, #63, LBB0_129
; %bb.70:                               ;   in Loop: Header=BB0_66 Depth=1
	lsl	x21, x21, #1
	b	LBB0_66
LBB0_71:
	stur	x21, [x29, #-176]
Ltmp44:                                 ; EH_LABEL
Lloh6:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh7:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh8:
	adrp	x1, l_.str.8@PAGE
Lloh9:
	add	x1, x1, l_.str.8@PAGEOFF
	mov	w2, #99                         ; =0x63
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp45:                                 ; EH_LABEL
; %bb.72:
	ldr	x8, [x0]
	ldur	x8, [x8, #-24]
	add	x8, x0, x8
	mov	w9, #12                         ; =0xc
	str	x9, [x8, #16]
Ltmp47:                                 ; EH_LABEL
	mov	w0, #12                         ; =0xc
	bl	__Znwm
Ltmp48:                                 ; EH_LABEL
; %bb.73:
	stp	x0, xzr, [sp, #88]              ; 16-byte Folded Spill
	mov	x8, #4294967296                 ; =0x100000000
	str	x8, [x0]
	mov	w8, #2                          ; =0x2
	str	w8, [x0, #8]
LBB0_74:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_75 Depth 2
                                        ;     Child Loop BB0_80 Depth 2
                                        ;     Child Loop BB0_85 Depth 2
                                        ;       Child Loop BB0_87 Depth 3
                                        ;       Child Loop BB0_91 Depth 3
	add	x8, sp, #136
	stur	x8, [x29, #-256]
	mov	w8, #2                          ; =0x2
	stp	x8, x8, [x29, #-248]
	mov	w9, #1                          ; =0x1
	stp	x9, x9, [x29, #-232]
	mov	x8, #4294967296                 ; =0x100000000
	stp	x8, x8, [x29, #-216]
	mov	x8, #3                          ; =0x3
	movk	x8, #7, lsl #32
	stur	x8, [x29, #-200]
LBB0_75:                                ;   Parent Loop BB0_74 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
Ltmp50:                                 ; EH_LABEL
	sub	x0, x29, #256
	bl	__ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE
Ltmp51:                                 ; EH_LABEL
; %bb.76:                               ;   in Loop: Header=BB0_75 Depth=2
	cmp	x0, #2
	b.hi	LBB0_75
; %bb.77:                               ;   in Loop: Header=BB0_74 Depth=1
	cbz	x0, LBB0_79
; %bb.78:                               ;   in Loop: Header=BB0_74 Depth=1
	ldr	x10, [sp, #88]                  ; 8-byte Reload
	ldr	w8, [x10]
	ldr	w9, [x10, x0, lsl #2]
	str	w9, [x10]
	str	w8, [x10, x0, lsl #2]
LBB0_79:                                ;   in Loop: Header=BB0_74 Depth=1
	add	x8, sp, #136
	mov	w9, #1                          ; =0x1
	stp	x8, x9, [x29, #-256]
	stp	x9, x9, [x29, #-240]
	mov	x10, #4294967296                ; =0x100000000
	stp	x9, x10, [x29, #-224]
	mov	x8, #1                          ; =0x1
	movk	x8, #3, lsl #32
	stp	x10, x8, [x29, #-208]
LBB0_80:                                ;   Parent Loop BB0_74 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
Ltmp53:                                 ; EH_LABEL
	sub	x0, x29, #256
	bl	__ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE
Ltmp54:                                 ; EH_LABEL
; %bb.81:                               ;   in Loop: Header=BB0_80 Depth=2
	cmp	x0, #1
	b.hi	LBB0_80
; %bb.82:                               ;   in Loop: Header=BB0_74 Depth=1
	cbz	x0, LBB0_84
; %bb.83:                               ;   in Loop: Header=BB0_74 Depth=1
	ldr	x10, [sp, #88]                  ; 8-byte Reload
	ldp	w8, w9, [x10, #4]
	stp	w9, w8, [x10, #4]
LBB0_84:                                ;   in Loop: Header=BB0_74 Depth=1
	mov	x9, #0                          ; =0x0
LBB0_85:                                ;   Parent Loop BB0_74 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_87 Depth 3
                                        ;       Child Loop BB0_91 Depth 3
	ldr	x8, [sp, #88]                   ; 8-byte Reload
	str	x9, [sp, #120]                  ; 8-byte Spill
	ldrsw	x9, [x8, x9]
	sub	x8, x29, #192
	str	x9, [sp, #128]                  ; 8-byte Spill
	ldr	x23, [x8, x9, lsl #3]
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	cbz	x23, LBB0_89
; %bb.86:                               ;   in Loop: Header=BB0_85 Depth=2
Lloh10:
	adrp	x8, l___const.main.kernels@PAGE
Lloh11:
	add	x8, x8, l___const.main.kernels@PAGEOFF
	ldr	x9, [sp, #128]                  ; 8-byte Reload
	ldr	x22, [x8, x9, lsl #3]
	sub	x8, x29, #144
	ldr	x19, [x8, x9, lsl #3]
	mov	x21, x23
LBB0_87:                                ;   Parent Loop BB0_74 Depth=1
                                        ;     Parent Loop BB0_85 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
Ltmp56:                                 ; EH_LABEL
	mov	x0, x20
	mov	x1, x19
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	blr	x22
Ltmp57:                                 ; EH_LABEL
; %bb.88:                               ;   in Loop: Header=BB0_87 Depth=3
	; InlineAsm Start
	; InlineAsm End
	subs	x21, x21, #1
	b.ne	LBB0_87
LBB0_89:                                ;   in Loop: Header=BB0_85 Depth=2
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	str	x0, [sp, #112]                  ; 8-byte Spill
	cbz	x23, LBB0_93
; %bb.90:                               ;   in Loop: Header=BB0_85 Depth=2
Lloh12:
	adrp	x8, l___const.main.kernels@PAGE
Lloh13:
	add	x8, x8, l___const.main.kernels@PAGEOFF
	ldr	x9, [sp, #128]                  ; 8-byte Reload
	ldr	x22, [x8, x9, lsl #3]
	sub	x8, x29, #144
	ldr	x19, [x8, x9, lsl #3]
	mov	x21, x23
LBB0_91:                                ;   Parent Loop BB0_74 Depth=1
                                        ;     Parent Loop BB0_85 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
Ltmp59:                                 ; EH_LABEL
	mov	x0, x20
	mov	x1, x19
	mov	x2, x25
	mov	x3, x26
	mov	x4, x27
	mov	x5, x28
	mov	x6, x24
	blr	x22
Ltmp60:                                 ; EH_LABEL
; %bb.92:                               ;   in Loop: Header=BB0_91 Depth=3
	; InlineAsm Start
	; InlineAsm End
	subs	x21, x21, #1
	b.ne	LBB0_91
LBB0_93:                                ;   in Loop: Header=BB0_85 Depth=2
	bl	__ZNSt3__16chrono12steady_clock3nowEv
	mov	x19, x0
Lloh14:
	adrp	x8, l___const.main.names@PAGE
Lloh15:
	add	x8, x8, l___const.main.names@PAGEOFF
	ldr	x9, [sp, #128]                  ; 8-byte Reload
	ldr	x22, [x8, x9, lsl #3]
	mov	x0, x22
	bl	_strlen
	mov	x2, x0
Ltmp62:                                 ; EH_LABEL
Lloh16:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh17:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
	mov	x1, x22
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp63:                                 ; EH_LABEL
; %bb.94:                               ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp64:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp65:                                 ; EH_LABEL
; %bb.95:                               ;   in Loop: Header=BB0_85 Depth=2
Ltmp66:                                 ; EH_LABEL
	mov	x1, x26
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp67:                                 ; EH_LABEL
; %bb.96:                               ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp68:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp69:                                 ; EH_LABEL
; %bb.97:                               ;   in Loop: Header=BB0_85 Depth=2
Ltmp70:                                 ; EH_LABEL
	mov	x1, x27
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp71:                                 ; EH_LABEL
; %bb.98:                               ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp72:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp73:                                 ; EH_LABEL
; %bb.99:                               ;   in Loop: Header=BB0_85 Depth=2
Ltmp74:                                 ; EH_LABEL
	mov	x1, x28
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp75:                                 ; EH_LABEL
; %bb.100:                              ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp76:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp77:                                 ; EH_LABEL
; %bb.101:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp78:                                 ; EH_LABEL
	mov	x1, x24
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp79:                                 ; EH_LABEL
; %bb.102:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp80:                                 ; EH_LABEL
Lloh18:
	adrp	x1, l_.str.9@PAGE
Lloh19:
	add	x1, x1, l_.str.9@PAGEOFF
	mov	w2, #3                          ; =0x3
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp81:                                 ; EH_LABEL
; %bb.103:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp82:                                 ; EH_LABEL
	ldr	x1, [sp, #96]                   ; 8-byte Reload
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp83:                                 ; EH_LABEL
; %bb.104:                              ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp84:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp85:                                 ; EH_LABEL
; %bb.105:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp86:                                 ; EH_LABEL
	mov	x1, x23
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp87:                                 ; EH_LABEL
; %bb.106:                              ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp88:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp89:                                 ; EH_LABEL
; %bb.107:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp90:                                 ; EH_LABEL
	ldr	x8, [sp, #112]                  ; 8-byte Reload
	sub	x8, x19, x8
	scvtf	d0, x8
	ucvtf	d1, x23
	fdiv	d0, d0, d1
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
Ltmp91:                                 ; EH_LABEL
; %bb.108:                              ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp92:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp93:                                 ; EH_LABEL
; %bb.109:                              ;   in Loop: Header=BB0_85 Depth=2
	sub	x8, x29, #168
	ldr	x9, [sp, #128]                  ; 8-byte Reload
	ldr	d0, [x8, x9, lsl #3]
Ltmp94:                                 ; EH_LABEL
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
Ltmp95:                                 ; EH_LABEL
; %bb.110:                              ;   in Loop: Header=BB0_85 Depth=2
	mov	w8, #44                         ; =0x2c
	sturb	w8, [x29, #-256]
Ltmp96:                                 ; EH_LABEL
	sub	x1, x29, #256
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp97:                                 ; EH_LABEL
; %bb.111:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp98:                                 ; EH_LABEL
	ldr	x1, [sp, #80]                   ; 8-byte Reload
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
Ltmp99:                                 ; EH_LABEL
; %bb.112:                              ;   in Loop: Header=BB0_85 Depth=2
Ltmp100:                                ; EH_LABEL
Lloh20:
	adrp	x1, l_.str.10@PAGE
Lloh21:
	add	x1, x1, l_.str.10@PAGEOFF
	mov	w2, #17                         ; =0x11
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp101:                                ; EH_LABEL
; %bb.113:                              ;   in Loop: Header=BB0_85 Depth=2
	ldr	x9, [sp, #120]                  ; 8-byte Reload
	add	x9, x9, #4
	cmp	x9, #12
	b.ne	LBB0_85
; %bb.114:                              ;   in Loop: Header=BB0_74 Depth=1
	ldr	x9, [sp, #96]                   ; 8-byte Reload
	add	x9, x9, #1
	ldr	x8, [sp, #40]                   ; 8-byte Reload
	str	x9, [sp, #96]                   ; 8-byte Spill
	cmp	x9, x8
	b.ne	LBB0_74
; %bb.115:
	ldr	x0, [sp, #88]                   ; 8-byte Reload
	mov	w1, #12                         ; =0xc
	bl	__ZdlPvm
	ldr	x0, [sp, #72]                   ; 8-byte Reload
	ldr	x1, [sp, #24]                   ; 8-byte Reload
	bl	__ZdlPvm
	mov	x0, x25
	ldr	x1, [sp, #32]                   ; 8-byte Reload
	bl	__ZdlPvm
	ldr	x0, [sp, #48]                   ; 8-byte Reload
	cbz	x0, LBB0_117
; %bb.116:
	ldr	x8, [sp]                        ; 8-byte Reload
	sub	x1, x8, x0
	bl	__ZdlPvm
LBB0_117:
	ldr	x19, [sp, #104]                 ; 8-byte Reload
	ldp	x0, x21, [sp, #56]              ; 16-byte Folded Reload
	cbz	x0, LBB0_119
; %bb.118:
	ldr	x8, [sp, #8]                    ; 8-byte Reload
	sub	x1, x8, x0
	bl	__ZdlPvm
LBB0_119:
	ldr	x8, [sp, #16]                   ; 8-byte Reload
	sub	x1, x8, x21
	mov	x0, x21
	bl	__ZdlPvm
	mov	x0, x20
	mov	x1, x19
	bl	__ZdlPvm
	mov	w0, #0                          ; =0x0
	ldur	x8, [x29, #-120]
Lloh22:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh23:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh24:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB0_192
LBB0_120:
	add	sp, sp, #2800
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #112              ; 16-byte Folded Reload
	ret
LBB0_121:
	stp	xzr, xzr, [sp, #48]             ; 16-byte Folded Spill
	stp	xzr, xzr, [sp, #8]              ; 16-byte Folded Spill
	mov	x25, #0                         ; =0x0
	str	xzr, [sp]                       ; 8-byte Spill
	str	x25, [sp, #64]                  ; 8-byte Spill
	str	x23, [sp, #104]                 ; 8-byte Spill
	lsr	x8, x26, #62
	cbz	x8, LBB0_24
LBB0_122:
Ltmp123:                                ; EH_LABEL
	bl	__ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev
Ltmp124:                                ; EH_LABEL
	b	LBB0_138
LBB0_123:
	mov	x22, #0                         ; =0x0
	sub	x8, x29, #168
LBB0_124:
	str	d0, [x8]
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp109:                                ; EH_LABEL
Lloh25:
	adrp	x1, l_.str.6@PAGE
Lloh26:
	add	x1, x1, l_.str.6@PAGEOFF
	sub	x0, x29, #192
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B9nqe220100ILi0EEEPKc
Ltmp110:                                ; EH_LABEL
; %bb.125:
Lloh27:
	adrp	x8, l___const.main.names@PAGE
Lloh28:
	add	x8, x8, l___const.main.names@PAGEOFF
	ldr	x1, [x8, x22, lsl #3]
Ltmp112:                                ; EH_LABEL
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKc
Ltmp113:                                ; EH_LABEL
; %bb.126:
	ldr	q0, [x0]
	ldr	x8, [x0, #16]
	stur	x8, [x29, #-240]
	sub	x8, x29, #256
	str	q0, [x8]
	stp	xzr, xzr, [x0, #8]
	str	xzr, [x0]
	mov	w23, #1                         ; =0x1
Ltmp115:                                ; EH_LABEL
	sub	x1, x29, #256
	mov	x0, x19
	bl	__ZNSt13runtime_errorC1ERKNSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE
Ltmp116:                                ; EH_LABEL
; %bb.127:
Ltmp117:                                ; EH_LABEL
	mov	w23, #0                         ; =0x0
Lloh29:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh30:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh31:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh32:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
Ltmp118:                                ; EH_LABEL
	b	LBB0_138
LBB0_128:
	sub	x8, x29, #192
	str	x8, [sp, #128]                  ; 8-byte Spill
LBB0_129:
	ldr	x8, [sp, #128]                  ; 8-byte Reload
	str	x21, [x8]
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp103:                                ; EH_LABEL
Lloh33:
	adrp	x1, l_.str.7@PAGE
Lloh34:
	add	x1, x1, l_.str.7@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp104:                                ; EH_LABEL
; %bb.130:
Ltmp106:                                ; EH_LABEL
Lloh35:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh36:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh37:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh38:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
Ltmp107:                                ; EH_LABEL
	b	LBB0_138
LBB0_131:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp129:                                ; EH_LABEL
Lloh39:
	adrp	x1, l_.str.2@PAGE
Lloh40:
	add	x1, x1, l_.str.2@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp130:                                ; EH_LABEL
	b	LBB0_135
LBB0_132:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp0:                                  ; EH_LABEL
Lloh41:
	adrp	x1, l_.str@PAGE
Lloh42:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp1:                                  ; EH_LABEL
; %bb.133:
Ltmp3:                                  ; EH_LABEL
Lloh43:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh44:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh45:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh46:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
Ltmp4:                                  ; EH_LABEL
	b	LBB0_138
LBB0_134:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp26:                                 ; EH_LABEL
Lloh47:
	adrp	x1, l_.str.1@PAGE
Lloh48:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp27:                                 ; EH_LABEL
LBB0_135:
Ltmp132:                                ; EH_LABEL
Lloh49:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh50:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh51:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh52:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
Ltmp133:                                ; EH_LABEL
	b	LBB0_138
LBB0_136:
Ltmp126:                                ; EH_LABEL
	bl	__ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev
Ltmp127:                                ; EH_LABEL
	b	LBB0_138
LBB0_137:
Ltmp120:                                ; EH_LABEL
	bl	__ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev
Ltmp121:                                ; EH_LABEL
LBB0_138:
	brk	#0x1
LBB0_139:
Ltmp28:                                 ; EH_LABEL
	b	LBB0_154
LBB0_140:
Ltmp5:                                  ; EH_LABEL
	b	LBB0_159
LBB0_141:
Ltmp2:                                  ; EH_LABEL
	b	LBB0_154
LBB0_142:
Ltmp39:                                 ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	ldr	x0, [sp, #56]                   ; 8-byte Reload
	b	LBB0_184
LBB0_143:
Ltmp36:                                 ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	b	LBB0_186
LBB0_144:
Ltmp33:                                 ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	b	LBB0_187
LBB0_145:
Ltmp49:                                 ; EH_LABEL
	b	LBB0_161
LBB0_146:
Ltmp46:                                 ; EH_LABEL
	b	LBB0_161
LBB0_147:
Ltmp23:                                 ; EH_LABEL
	b	LBB0_159
LBB0_148:
Ltmp20:                                 ; EH_LABEL
	b	LBB0_159
LBB0_149:
Ltmp17:                                 ; EH_LABEL
	b	LBB0_159
LBB0_150:
Ltmp14:                                 ; EH_LABEL
	b	LBB0_159
LBB0_151:
Ltmp11:                                 ; EH_LABEL
	b	LBB0_159
LBB0_152:
Ltmp8:                                  ; EH_LABEL
	b	LBB0_159
LBB0_153:
Ltmp131:                                ; EH_LABEL
LBB0_154:
	mov	x21, x1
	mov	x22, x0
	mov	x0, x19
	bl	___cxa_free_exception
	b	LBB0_188
LBB0_155:
Ltmp122:                                ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	b	LBB0_180
LBB0_156:
Ltmp125:                                ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	b	LBB0_181
LBB0_157:
Ltmp128:                                ; EH_LABEL
	b	LBB0_159
LBB0_158:
Ltmp134:                                ; EH_LABEL
LBB0_159:
	mov	x21, x1
	mov	x22, x0
	b	LBB0_188
LBB0_160:
Ltmp108:                                ; EH_LABEL
LBB0_161:
	mov	x21, x1
	mov	x22, x0
	b	LBB0_179
LBB0_162:
Ltmp105:                                ; EH_LABEL
	b	LBB0_171
LBB0_163:
Ltmp119:                                ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	ldursb	w8, [x29, #-233]
	tbnz	w8, #31, LBB0_166
; %bb.164:
	ldursb	w8, [x29, #-169]
	tbnz	w8, #31, LBB0_169
LBB0_165:
	tbnz	w23, #0, LBB0_172
	b	LBB0_179
LBB0_166:
	ldur	x0, [x29, #-256]
	ldur	x8, [x29, #-240]
	and	x1, x8, #0x7fffffffffffffff
	bl	__ZdlPvm
	ldursb	w8, [x29, #-169]
	tbz	w8, #31, LBB0_165
	b	LBB0_169
LBB0_167:
Ltmp114:                                ; EH_LABEL
	mov	x21, x1
	mov	x22, x0
	ldursb	w8, [x29, #-169]
	tbz	w8, #31, LBB0_172
; %bb.168:
	mov	w23, #1                         ; =0x1
LBB0_169:
	ldur	x0, [x29, #-192]
	ldur	x8, [x29, #-176]
	and	x1, x8, #0x7fffffffffffffff
	bl	__ZdlPvm
	tbnz	w23, #0, LBB0_172
	b	LBB0_179
LBB0_170:
Ltmp111:                                ; EH_LABEL
LBB0_171:
	mov	x21, x1
	mov	x22, x0
LBB0_172:
	mov	x0, x19
	bl	___cxa_free_exception
	b	LBB0_179
LBB0_173:
Ltmp55:                                 ; EH_LABEL
	b	LBB0_178
LBB0_174:
Ltmp52:                                 ; EH_LABEL
	b	LBB0_178
LBB0_175:
Ltmp61:                                 ; EH_LABEL
	b	LBB0_178
LBB0_176:
Ltmp102:                                ; EH_LABEL
	b	LBB0_178
LBB0_177:
Ltmp58:                                 ; EH_LABEL
LBB0_178:
	mov	x21, x1
	mov	x22, x0
	ldr	x0, [sp, #88]                   ; 8-byte Reload
	mov	w1, #12                         ; =0xc
	bl	__ZdlPvm
LBB0_179:
	ldr	x0, [sp, #72]                   ; 8-byte Reload
	ldr	x1, [sp, #24]                   ; 8-byte Reload
	bl	__ZdlPvm
LBB0_180:
	mov	x0, x25
	ldr	x1, [sp, #32]                   ; 8-byte Reload
	bl	__ZdlPvm
LBB0_181:
	ldr	x23, [sp, #104]                 ; 8-byte Reload
	ldr	x25, [sp, #64]                  ; 8-byte Reload
	ldr	x0, [sp, #48]                   ; 8-byte Reload
	cbz	x0, LBB0_183
; %bb.182:
	ldr	x8, [sp]                        ; 8-byte Reload
	sub	x1, x8, x0
	bl	__ZdlPvm
LBB0_183:
	ldr	x0, [sp, #56]                   ; 8-byte Reload
	cbz	x0, LBB0_185
LBB0_184:
	ldr	x8, [sp, #8]                    ; 8-byte Reload
	sub	x1, x8, x0
	bl	__ZdlPvm
LBB0_185:
	cbz	x25, LBB0_187
LBB0_186:
	ldr	x8, [sp, #16]                   ; 8-byte Reload
	sub	x1, x8, x25
	mov	x0, x25
	bl	__ZdlPvm
LBB0_187:
	mov	x0, x20
	mov	x1, x23
	bl	__ZdlPvm
LBB0_188:
	cmp	w21, #1
	b.ne	LBB0_194
; %bb.189:
	mov	x0, x22
	bl	___cxa_begin_catch
	ldr	x8, [x0]
	ldr	x8, [x8, #16]
	blr	x8
	mov	x19, x0
	bl	_strlen
	mov	x2, x0
Ltmp135:                                ; EH_LABEL
Lloh53:
	adrp	x0, __ZNSt3__14cerrE@GOTPAGE
Lloh54:
	ldr	x0, [x0, __ZNSt3__14cerrE@GOTPAGEOFF]
	mov	x1, x19
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp136:                                ; EH_LABEL
; %bb.190:
	mov	w8, #10                         ; =0xa
	strb	w8, [sp, #136]
Ltmp137:                                ; EH_LABEL
	add	x1, sp, #136
	mov	w2, #1                          ; =0x1
	bl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp138:                                ; EH_LABEL
; %bb.191:
	bl	___cxa_end_catch
	mov	w0, #1                          ; =0x1
	ldur	x8, [x29, #-120]
Lloh55:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh56:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh57:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB0_120
LBB0_192:
	bl	___stack_chk_fail
LBB0_193:
Ltmp139:                                ; EH_LABEL
	mov	x22, x0
Ltmp140:                                ; EH_LABEL
	bl	___cxa_end_catch
Ltmp141:                                ; EH_LABEL
LBB0_194:
	mov	x0, x22
	bl	__Unwind_Resume
LBB0_195:
Ltmp142:                                ; EH_LABEL
	bl	___clang_call_terminate
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpAddLdr	Lloh3, Lloh4, Lloh5
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpLdrGot	Lloh6, Lloh7
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpLdrGot	Lloh16, Lloh17
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpLdrGotLdr	Lloh22, Lloh23, Lloh24
	.loh AdrpAdd	Lloh25, Lloh26
	.loh AdrpAdd	Lloh27, Lloh28
	.loh AdrpLdrGot	Lloh31, Lloh32
	.loh AdrpLdrGot	Lloh29, Lloh30
	.loh AdrpAdd	Lloh33, Lloh34
	.loh AdrpLdrGot	Lloh37, Lloh38
	.loh AdrpLdrGot	Lloh35, Lloh36
	.loh AdrpAdd	Lloh39, Lloh40
	.loh AdrpAdd	Lloh41, Lloh42
	.loh AdrpLdrGot	Lloh45, Lloh46
	.loh AdrpLdrGot	Lloh43, Lloh44
	.loh AdrpAdd	Lloh47, Lloh48
	.loh AdrpLdrGot	Lloh51, Lloh52
	.loh AdrpLdrGot	Lloh49, Lloh50
	.loh AdrpLdrGot	Lloh53, Lloh54
	.loh AdrpLdrGotLdr	Lloh55, Lloh56, Lloh57
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table0:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase0-Lttbaseref0
Lttbaseref0:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Ltmp6-Lfunc_begin0             ; >> Call Site 1 <<
	.uleb128 Ltmp7-Ltmp6                    ;   Call between Ltmp6 and Ltmp7
	.uleb128 Ltmp8-Lfunc_begin0             ;     jumps to Ltmp8
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp9-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp10-Ltmp9                   ;   Call between Ltmp9 and Ltmp10
	.uleb128 Ltmp11-Lfunc_begin0            ;     jumps to Ltmp11
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp12-Lfunc_begin0            ; >> Call Site 3 <<
	.uleb128 Ltmp13-Ltmp12                  ;   Call between Ltmp12 and Ltmp13
	.uleb128 Ltmp14-Lfunc_begin0            ;     jumps to Ltmp14
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp15-Lfunc_begin0            ; >> Call Site 4 <<
	.uleb128 Ltmp16-Ltmp15                  ;   Call between Ltmp15 and Ltmp16
	.uleb128 Ltmp17-Lfunc_begin0            ;     jumps to Ltmp17
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp18-Lfunc_begin0            ; >> Call Site 5 <<
	.uleb128 Ltmp19-Ltmp18                  ;   Call between Ltmp18 and Ltmp19
	.uleb128 Ltmp20-Lfunc_begin0            ;     jumps to Ltmp20
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp21-Lfunc_begin0            ; >> Call Site 6 <<
	.uleb128 Ltmp22-Ltmp21                  ;   Call between Ltmp21 and Ltmp22
	.uleb128 Ltmp23-Lfunc_begin0            ;     jumps to Ltmp23
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp24-Lfunc_begin0            ; >> Call Site 7 <<
	.uleb128 Ltmp25-Ltmp24                  ;   Call between Ltmp24 and Ltmp25
	.uleb128 Ltmp134-Lfunc_begin0           ;     jumps to Ltmp134
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp29-Lfunc_begin0            ; >> Call Site 8 <<
	.uleb128 Ltmp30-Ltmp29                  ;   Call between Ltmp29 and Ltmp30
	.uleb128 Ltmp128-Lfunc_begin0           ;     jumps to Ltmp128
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp30-Lfunc_begin0            ; >> Call Site 9 <<
	.uleb128 Ltmp31-Ltmp30                  ;   Call between Ltmp30 and Ltmp31
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp31-Lfunc_begin0            ; >> Call Site 10 <<
	.uleb128 Ltmp32-Ltmp31                  ;   Call between Ltmp31 and Ltmp32
	.uleb128 Ltmp33-Lfunc_begin0            ;     jumps to Ltmp33
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp32-Lfunc_begin0            ; >> Call Site 11 <<
	.uleb128 Ltmp34-Ltmp32                  ;   Call between Ltmp32 and Ltmp34
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp34-Lfunc_begin0            ; >> Call Site 12 <<
	.uleb128 Ltmp35-Ltmp34                  ;   Call between Ltmp34 and Ltmp35
	.uleb128 Ltmp36-Lfunc_begin0            ;     jumps to Ltmp36
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp35-Lfunc_begin0            ; >> Call Site 13 <<
	.uleb128 Ltmp37-Ltmp35                  ;   Call between Ltmp35 and Ltmp37
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp37-Lfunc_begin0            ; >> Call Site 14 <<
	.uleb128 Ltmp38-Ltmp37                  ;   Call between Ltmp37 and Ltmp38
	.uleb128 Ltmp39-Lfunc_begin0            ;     jumps to Ltmp39
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp38-Lfunc_begin0            ; >> Call Site 15 <<
	.uleb128 Ltmp40-Ltmp38                  ;   Call between Ltmp38 and Ltmp40
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp40-Lfunc_begin0            ; >> Call Site 16 <<
	.uleb128 Ltmp41-Ltmp40                  ;   Call between Ltmp40 and Ltmp41
	.uleb128 Ltmp125-Lfunc_begin0           ;     jumps to Ltmp125
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp41-Lfunc_begin0            ; >> Call Site 17 <<
	.uleb128 Ltmp42-Ltmp41                  ;   Call between Ltmp41 and Ltmp42
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp42-Lfunc_begin0            ; >> Call Site 18 <<
	.uleb128 Ltmp43-Ltmp42                  ;   Call between Ltmp42 and Ltmp43
	.uleb128 Ltmp122-Lfunc_begin0           ;     jumps to Ltmp122
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp43-Lfunc_begin0            ; >> Call Site 19 <<
	.uleb128 Ltmp44-Ltmp43                  ;   Call between Ltmp43 and Ltmp44
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp44-Lfunc_begin0            ; >> Call Site 20 <<
	.uleb128 Ltmp45-Ltmp44                  ;   Call between Ltmp44 and Ltmp45
	.uleb128 Ltmp46-Lfunc_begin0            ;     jumps to Ltmp46
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp47-Lfunc_begin0            ; >> Call Site 21 <<
	.uleb128 Ltmp48-Ltmp47                  ;   Call between Ltmp47 and Ltmp48
	.uleb128 Ltmp49-Lfunc_begin0            ;     jumps to Ltmp49
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp50-Lfunc_begin0            ; >> Call Site 22 <<
	.uleb128 Ltmp51-Ltmp50                  ;   Call between Ltmp50 and Ltmp51
	.uleb128 Ltmp52-Lfunc_begin0            ;     jumps to Ltmp52
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp53-Lfunc_begin0            ; >> Call Site 23 <<
	.uleb128 Ltmp54-Ltmp53                  ;   Call between Ltmp53 and Ltmp54
	.uleb128 Ltmp55-Lfunc_begin0            ;     jumps to Ltmp55
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp56-Lfunc_begin0            ; >> Call Site 24 <<
	.uleb128 Ltmp57-Ltmp56                  ;   Call between Ltmp56 and Ltmp57
	.uleb128 Ltmp58-Lfunc_begin0            ;     jumps to Ltmp58
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp59-Lfunc_begin0            ; >> Call Site 25 <<
	.uleb128 Ltmp60-Ltmp59                  ;   Call between Ltmp59 and Ltmp60
	.uleb128 Ltmp61-Lfunc_begin0            ;     jumps to Ltmp61
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp62-Lfunc_begin0            ; >> Call Site 26 <<
	.uleb128 Ltmp101-Ltmp62                 ;   Call between Ltmp62 and Ltmp101
	.uleb128 Ltmp102-Lfunc_begin0           ;     jumps to Ltmp102
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp123-Lfunc_begin0           ; >> Call Site 27 <<
	.uleb128 Ltmp124-Ltmp123                ;   Call between Ltmp123 and Ltmp124
	.uleb128 Ltmp125-Lfunc_begin0           ;     jumps to Ltmp125
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp124-Lfunc_begin0           ; >> Call Site 28 <<
	.uleb128 Ltmp109-Ltmp124                ;   Call between Ltmp124 and Ltmp109
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp109-Lfunc_begin0           ; >> Call Site 29 <<
	.uleb128 Ltmp110-Ltmp109                ;   Call between Ltmp109 and Ltmp110
	.uleb128 Ltmp111-Lfunc_begin0           ;     jumps to Ltmp111
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp112-Lfunc_begin0           ; >> Call Site 30 <<
	.uleb128 Ltmp113-Ltmp112                ;   Call between Ltmp112 and Ltmp113
	.uleb128 Ltmp114-Lfunc_begin0           ;     jumps to Ltmp114
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp115-Lfunc_begin0           ; >> Call Site 31 <<
	.uleb128 Ltmp118-Ltmp115                ;   Call between Ltmp115 and Ltmp118
	.uleb128 Ltmp119-Lfunc_begin0           ;     jumps to Ltmp119
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp118-Lfunc_begin0           ; >> Call Site 32 <<
	.uleb128 Ltmp103-Ltmp118                ;   Call between Ltmp118 and Ltmp103
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp103-Lfunc_begin0           ; >> Call Site 33 <<
	.uleb128 Ltmp104-Ltmp103                ;   Call between Ltmp103 and Ltmp104
	.uleb128 Ltmp105-Lfunc_begin0           ;     jumps to Ltmp105
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp106-Lfunc_begin0           ; >> Call Site 34 <<
	.uleb128 Ltmp107-Ltmp106                ;   Call between Ltmp106 and Ltmp107
	.uleb128 Ltmp108-Lfunc_begin0           ;     jumps to Ltmp108
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp107-Lfunc_begin0           ; >> Call Site 35 <<
	.uleb128 Ltmp129-Ltmp107                ;   Call between Ltmp107 and Ltmp129
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp129-Lfunc_begin0           ; >> Call Site 36 <<
	.uleb128 Ltmp130-Ltmp129                ;   Call between Ltmp129 and Ltmp130
	.uleb128 Ltmp131-Lfunc_begin0           ;     jumps to Ltmp131
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp130-Lfunc_begin0           ; >> Call Site 37 <<
	.uleb128 Ltmp0-Ltmp130                  ;   Call between Ltmp130 and Ltmp0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 38 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp2-Lfunc_begin0             ;     jumps to Ltmp2
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp3-Lfunc_begin0             ; >> Call Site 39 <<
	.uleb128 Ltmp4-Ltmp3                    ;   Call between Ltmp3 and Ltmp4
	.uleb128 Ltmp5-Lfunc_begin0             ;     jumps to Ltmp5
	.byte	5                               ;   On action: 3
	.uleb128 Ltmp4-Lfunc_begin0             ; >> Call Site 40 <<
	.uleb128 Ltmp26-Ltmp4                   ;   Call between Ltmp4 and Ltmp26
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp26-Lfunc_begin0            ; >> Call Site 41 <<
	.uleb128 Ltmp27-Ltmp26                  ;   Call between Ltmp26 and Ltmp27
	.uleb128 Ltmp28-Lfunc_begin0            ;     jumps to Ltmp28
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp132-Lfunc_begin0           ; >> Call Site 42 <<
	.uleb128 Ltmp133-Ltmp132                ;   Call between Ltmp132 and Ltmp133
	.uleb128 Ltmp134-Lfunc_begin0           ;     jumps to Ltmp134
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp126-Lfunc_begin0           ; >> Call Site 43 <<
	.uleb128 Ltmp127-Ltmp126                ;   Call between Ltmp126 and Ltmp127
	.uleb128 Ltmp128-Lfunc_begin0           ;     jumps to Ltmp128
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp120-Lfunc_begin0           ; >> Call Site 44 <<
	.uleb128 Ltmp121-Ltmp120                ;   Call between Ltmp120 and Ltmp121
	.uleb128 Ltmp122-Lfunc_begin0           ;     jumps to Ltmp122
	.byte	3                               ;   On action: 2
	.uleb128 Ltmp121-Lfunc_begin0           ; >> Call Site 45 <<
	.uleb128 Ltmp135-Ltmp121                ;   Call between Ltmp121 and Ltmp135
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp135-Lfunc_begin0           ; >> Call Site 46 <<
	.uleb128 Ltmp138-Ltmp135                ;   Call between Ltmp135 and Ltmp138
	.uleb128 Ltmp139-Lfunc_begin0           ;     jumps to Ltmp139
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp138-Lfunc_begin0           ; >> Call Site 47 <<
	.uleb128 Ltmp140-Ltmp138                ;   Call between Ltmp138 and Ltmp140
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp140-Lfunc_begin0           ; >> Call Site 48 <<
	.uleb128 Ltmp141-Ltmp140                ;   Call between Ltmp140 and Ltmp141
	.uleb128 Ltmp142-Lfunc_begin0           ;     jumps to Ltmp142
	.byte	7                               ;   On action: 4
	.uleb128 Ltmp141-Lfunc_begin0           ; >> Call Site 49 <<
	.uleb128 Lfunc_end0-Ltmp141             ;   Call between Ltmp141 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.byte	0                               ; >> Action Record 1 <<
                                        ;   Cleanup
	.byte	0                               ;   No further actions
	.byte	1                               ; >> Action Record 2 <<
                                        ;   Catch TypeInfo 1
	.byte	125                             ;   Continue to action 1
	.byte	1                               ; >> Action Record 3 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.byte	2                               ; >> Action Record 4 <<
                                        ;   Catch TypeInfo 2
	.byte	0                               ;   No further actions
	.p2align	2, 0x0
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 2
Ltmp185:                                ; TypeInfo 1
	.long	__ZTISt9exception@GOT-Ltmp185
Lttbase0:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2                               ; -- Begin function _ZZ4mainENK3$_0clEPKc
__ZZ4mainENK3$_0clEPKc:                 ; @"_ZZ4mainENK3$_0clEPKc"
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
; %bb.0:
	sub	sp, sp, #80
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x0
	bl	_strlen
	mov	x8, #-9                         ; =0xfffffffffffffff7
	movk	x8, #32767, lsl #48
	cmp	x0, x8
	b.hs	LBB1_13
; %bb.1:
	mov	x20, x0
	cmp	x0, #22
	b.hi	LBB1_3
; %bb.2:
	strb	w20, [sp, #31]
	add	x21, sp, #8
	b	LBB1_4
LBB1_3:
	and	x8, x20, #0x7ffffffffffffff8
	add	x8, x8, #8
	mov	w9, #25                         ; =0x19
	cmp	x8, #24
	csel	x22, x9, x8, eq
	mov	x0, x22
	bl	__Znwm
	mov	x21, x0
	orr	x8, x22, #0x8000000000000000
	stp	x0, x20, [sp, #8]
	str	x8, [sp, #24]
LBB1_4:
	mov	x0, x21
	mov	x1, x19
	mov	x2, x20
	bl	_memcpy
	strb	wzr, [x21, x20]
	str	xzr, [sp]
	ldrb	w8, [sp, #31]
	sxtb	w9, w8
	ldr	x10, [sp, #16]
	cmp	w9, #0
	csel	x8, x10, x8, mi
	cbz	x8, LBB1_11
; %bb.5:
	ldr	x8, [sp, #8]
	add	x9, sp, #8
	csel	x8, x8, x9, mi
	ldrb	w8, [x8]
	cmp	w8, #45
	b.eq	LBB1_11
; %bb.6:
Ltmp143:                                ; EH_LABEL
	add	x0, sp, #8
	mov	x1, sp
	mov	w2, #10                         ; =0xa
	bl	__ZNSt3__16stoullERKNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPmi
Ltmp144:                                ; EH_LABEL
; %bb.7:
	ldr	x9, [sp]
	ldrb	w10, [sp, #31]
	sxtb	w8, w10
	ldr	x11, [sp, #16]
	cmp	w8, #0
	csel	x10, x11, x10, mi
	cmp	x9, x10
	b.ne	LBB1_14
; %bb.8:
	tbnz	w8, #31, LBB1_10
; %bb.9:
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
LBB1_10:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	and	x1, x9, #0x7fffffffffffffff
	mov	x19, x0
	mov	x0, x8
	bl	__ZdlPvm
	mov	x0, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
LBB1_11:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x20, x0
Ltmp151:                                ; EH_LABEL
Lloh58:
	adrp	x1, l_.str.11@PAGE
Lloh59:
	add	x1, x1, l_.str.11@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp152:                                ; EH_LABEL
; %bb.12:
Ltmp154:                                ; EH_LABEL
Lloh60:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh61:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh62:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh63:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x20
	bl	___cxa_throw
Ltmp155:                                ; EH_LABEL
	b	LBB1_16
LBB1_13:
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
LBB1_14:
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x20, x0
Ltmp145:                                ; EH_LABEL
Lloh64:
	adrp	x1, l_.str.12@PAGE
Lloh65:
	add	x1, x1, l_.str.12@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp146:                                ; EH_LABEL
; %bb.15:
Ltmp148:                                ; EH_LABEL
Lloh66:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh67:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh68:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh69:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x20
	bl	___cxa_throw
Ltmp149:                                ; EH_LABEL
LBB1_16:
	brk	#0x1
LBB1_17:
Ltmp147:                                ; EH_LABEL
	b	LBB1_20
LBB1_18:
Ltmp156:                                ; EH_LABEL
	b	LBB1_22
LBB1_19:
Ltmp153:                                ; EH_LABEL
LBB1_20:
	mov	x19, x0
	mov	x0, x20
	bl	___cxa_free_exception
	b	LBB1_23
LBB1_21:
Ltmp150:                                ; EH_LABEL
LBB1_22:
	mov	x19, x0
LBB1_23:
	ldrsb	w8, [sp, #31]
	tbz	w8, #31, LBB1_25
; %bb.24:
	ldr	x0, [sp, #8]
	ldr	x8, [sp, #24]
	and	x1, x8, #0x7fffffffffffffff
	bl	__ZdlPvm
LBB1_25:
	mov	x0, x19
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpLdrGot	Lloh62, Lloh63
	.loh AdrpLdrGot	Lloh60, Lloh61
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpLdrGot	Lloh68, Lloh69
	.loh AdrpLdrGot	Lloh66, Lloh67
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table1:
Lexception1:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Lfunc_begin1-Lfunc_begin1      ; >> Call Site 1 <<
	.uleb128 Ltmp143-Lfunc_begin1           ;   Call between Lfunc_begin1 and Ltmp143
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp143-Lfunc_begin1           ; >> Call Site 2 <<
	.uleb128 Ltmp144-Ltmp143                ;   Call between Ltmp143 and Ltmp144
	.uleb128 Ltmp150-Lfunc_begin1           ;     jumps to Ltmp150
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp144-Lfunc_begin1           ; >> Call Site 3 <<
	.uleb128 Ltmp151-Ltmp144                ;   Call between Ltmp144 and Ltmp151
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp151-Lfunc_begin1           ; >> Call Site 4 <<
	.uleb128 Ltmp152-Ltmp151                ;   Call between Ltmp151 and Ltmp152
	.uleb128 Ltmp153-Lfunc_begin1           ;     jumps to Ltmp153
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp154-Lfunc_begin1           ; >> Call Site 5 <<
	.uleb128 Ltmp155-Ltmp154                ;   Call between Ltmp154 and Ltmp155
	.uleb128 Ltmp156-Lfunc_begin1           ;     jumps to Ltmp156
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp155-Lfunc_begin1           ; >> Call Site 6 <<
	.uleb128 Ltmp145-Ltmp155                ;   Call between Ltmp155 and Ltmp145
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp145-Lfunc_begin1           ; >> Call Site 7 <<
	.uleb128 Ltmp146-Ltmp145                ;   Call between Ltmp145 and Ltmp146
	.uleb128 Ltmp147-Lfunc_begin1           ;     jumps to Ltmp147
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp148-Lfunc_begin1           ; >> Call Site 8 <<
	.uleb128 Ltmp149-Ltmp148                ;   Call between Ltmp148 and Ltmp149
	.uleb128 Ltmp150-Lfunc_begin1           ;     jumps to Ltmp150
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp149-Lfunc_begin1           ; >> Call Site 9 <<
	.uleb128 Lfunc_end1-Ltmp149             ;   Call between Ltmp149 and Lfunc_end1
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end1:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__Z3dotIL6Layout0EEvPKfS2_Pfmmmm ; -- Begin function _Z3dotIL6Layout0EEvPKfS2_Pfmmmm
	.weak_definition	__Z3dotIL6Layout0EEvPKfS2_Pfmmmm
	.p2align	2
__Z3dotIL6Layout0EEvPKfS2_Pfmmmm:       ; @_Z3dotIL6Layout0EEvPKfS2_Pfmmmm
	.cfi_startproc
; %bb.0:
	cbz	x3, LBB2_6
; %bb.1:
	cbz	x5, LBB2_7
; %bb.2:
	mov	x8, #0                          ; =0x0
	mul	x9, x6, x5
	add	x9, x1, x9, lsl #2
	mul	x10, x5, x4
	lsl	x10, x10, #2
LBB2_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_4 Depth 2
	movi.2d	v0, #0000000000000000
	mov	x11, x0
	mov	x12, x9
	mov	x13, x5
LBB2_4:                                 ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s1, [x11], #4
	ldr	s2, [x12], #4
	fmadd	s0, s1, s2, s0
	subs	x13, x13, #1
	b.ne	LBB2_4
; %bb.5:                                ;   in Loop: Header=BB2_3 Depth=1
	str	s0, [x2, x8, lsl #2]
	add	x8, x8, #1
	add	x9, x9, x10
	cmp	x8, x3
	b.ne	LBB2_3
LBB2_6:
	ret
LBB2_7:
	lsl	x1, x3, #2
	mov	x0, x2
	b	_bzero
	.cfi_endproc
                                        ; -- End function
	.globl	__Z3dotIL6Layout1EEvPKfS2_Pfmmmm ; -- Begin function _Z3dotIL6Layout1EEvPKfS2_Pfmmmm
	.weak_definition	__Z3dotIL6Layout1EEvPKfS2_Pfmmmm
	.p2align	2
__Z3dotIL6Layout1EEvPKfS2_Pfmmmm:       ; @_Z3dotIL6Layout1EEvPKfS2_Pfmmmm
	.cfi_startproc
; %bb.0:
	cbz	x3, LBB3_6
; %bb.1:
	cbz	x5, LBB3_7
; %bb.2:
	mov	x8, #0                          ; =0x0
	mul	x9, x6, x5
	mul	x9, x9, x3
	add	x9, x1, x9, lsl #2
	lsl	x10, x5, #2
LBB3_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_4 Depth 2
	movi.2d	v0, #0000000000000000
	mov	x11, x0
	mov	x12, x9
	mov	x13, x5
LBB3_4:                                 ;   Parent Loop BB3_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s1, [x11], #4
	ldr	s2, [x12], #4
	fmadd	s0, s1, s2, s0
	subs	x13, x13, #1
	b.ne	LBB3_4
; %bb.5:                                ;   in Loop: Header=BB3_3 Depth=1
	str	s0, [x2, x8, lsl #2]
	add	x8, x8, #1
	add	x9, x9, x10
	cmp	x8, x3
	b.ne	LBB3_3
LBB3_6:
	ret
LBB3_7:
	lsl	x1, x3, #2
	mov	x0, x2
	b	_bzero
	.cfi_endproc
                                        ; -- End function
	.globl	__Z3dotIL6Layout2EEvPKfS2_Pfmmmm ; -- Begin function _Z3dotIL6Layout2EEvPKfS2_Pfmmmm
	.weak_definition	__Z3dotIL6Layout2EEvPKfS2_Pfmmmm
	.p2align	2
__Z3dotIL6Layout2EEvPKfS2_Pfmmmm:       ; @_Z3dotIL6Layout2EEvPKfS2_Pfmmmm
	.cfi_startproc
; %bb.0:
	cbz	x3, LBB4_6
; %bb.1:
	cbz	x5, LBB4_7
; %bb.2:
	mov	x8, #0                          ; =0x0
	add	x9, x1, x6, lsl #2
	lsl	x10, x4, #2
	mul	x11, x4, x3
	lsl	x11, x11, #2
LBB4_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_4 Depth 2
	movi.2d	v0, #0000000000000000
	mov	x12, x0
	mov	x13, x9
	mov	x14, x5
LBB4_4:                                 ;   Parent Loop BB4_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	s1, [x12], #4
	ldr	s2, [x13]
	fmadd	s0, s1, s2, s0
	add	x13, x13, x11
	subs	x14, x14, #1
	b.ne	LBB4_4
; %bb.5:                                ;   in Loop: Header=BB4_3 Depth=1
	str	s0, [x2, x8, lsl #2]
	add	x8, x8, #1
	add	x9, x9, x10
	cmp	x8, x3
	b.ne	LBB4_3
LBB4_6:
	ret
LBB4_7:
	lsl	x1, x3, #2
	mov	x0, x2
	b	_bzero
	.cfi_endproc
                                        ; -- End function
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B9nqe220100ILi0EEEPKc ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B9nqe220100ILi0EEEPKc
	.weak_def_can_be_hidden	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B9nqe220100ILi0EEEPKc
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B9nqe220100ILi0EEEPKc: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B9nqe220100ILi0EEEPKc
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x20, x1
	mov	x19, x0
	mov	x0, x1
	bl	_strlen
	mov	x8, #-9                         ; =0xfffffffffffffff7
	movk	x8, #32767, lsl #48
	cmp	x0, x8
	b.hs	LBB5_5
; %bb.1:
	mov	x21, x0
	cmp	x0, #22
	b.hi	LBB5_3
; %bb.2:
	strb	w21, [x19, #23]
	mov	x22, x19
	b	LBB5_4
LBB5_3:
	and	x8, x21, #0x7ffffffffffffff8
	add	x8, x8, #8
	mov	w9, #25                         ; =0x19
	cmp	x8, #24
	csel	x23, x9, x8, eq
	mov	x0, x23
	bl	__Znwm
	mov	x22, x0
	orr	x8, x23, #0x8000000000000000
	stp	x0, x21, [x19]
	str	x8, [x19, #16]
LBB5_4:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	bl	_memmove
	strb	wzr, [x22, x21]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB5_5:
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
	.cfi_endproc
                                        ; -- End function
	.private_extern	___clang_call_terminate ; -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_def_can_be_hidden	___clang_call_terminate
	.p2align	2
___clang_call_terminate:                ; @__clang_call_terminate
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	___cxa_begin_catch
	bl	__ZSt9terminatev
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
	.weak_def_can_be_hidden	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh70:
	adrp	x0, l_.str.13@PAGE
Lloh71:
	add	x0, x0, l_.str.13@PAGEOFF
	bl	__ZNSt3__120__throw_length_errorB9nqe220100EPKc
	.loh AdrpAdd	Lloh70, Lloh71
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__120__throw_length_errorB9nqe220100EPKc ; -- Begin function _ZNSt3__120__throw_length_errorB9nqe220100EPKc
	.globl	__ZNSt3__120__throw_length_errorB9nqe220100EPKc
	.weak_def_can_be_hidden	__ZNSt3__120__throw_length_errorB9nqe220100EPKc
	.p2align	2
__ZNSt3__120__throw_length_errorB9nqe220100EPKc: ; @_ZNSt3__120__throw_length_errorB9nqe220100EPKc
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x20, x0
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp157:                                ; EH_LABEL
	mov	x1, x20
	bl	__ZNSt12length_errorC1B9nqe220100EPKc
Ltmp158:                                ; EH_LABEL
; %bb.1:
Lloh72:
	adrp	x1, __ZTISt12length_error@GOTPAGE
Lloh73:
	ldr	x1, [x1, __ZTISt12length_error@GOTPAGEOFF]
Lloh74:
	adrp	x2, __ZNSt12length_errorD1Ev@GOTPAGE
Lloh75:
	ldr	x2, [x2, __ZNSt12length_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB8_2:
Ltmp159:                                ; EH_LABEL
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpLdrGot	Lloh74, Lloh75
	.loh AdrpLdrGot	Lloh72, Lloh73
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table8:
Lexception2:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Lfunc_begin2-Lfunc_begin2      ; >> Call Site 1 <<
	.uleb128 Ltmp157-Lfunc_begin2           ;   Call between Lfunc_begin2 and Ltmp157
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp157-Lfunc_begin2           ; >> Call Site 2 <<
	.uleb128 Ltmp158-Ltmp157                ;   Call between Ltmp157 and Ltmp158
	.uleb128 Ltmp159-Lfunc_begin2           ;     jumps to Ltmp159
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp158-Lfunc_begin2           ; >> Call Site 3 <<
	.uleb128 Lfunc_end2-Ltmp158             ;   Call between Ltmp158 and Lfunc_end2
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end2:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt12length_errorC1B9nqe220100EPKc ; -- Begin function _ZNSt12length_errorC1B9nqe220100EPKc
	.globl	__ZNSt12length_errorC1B9nqe220100EPKc
	.weak_def_can_be_hidden	__ZNSt12length_errorC1B9nqe220100EPKc
	.p2align	2
__ZNSt12length_errorC1B9nqe220100EPKc:  ; @_ZNSt12length_errorC1B9nqe220100EPKc
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZNSt11logic_errorC2EPKc
Lloh76:
	adrp	x8, __ZTVSt12length_error@GOTPAGE
Lloh77:
	ldr	x8, [x8, __ZTVSt12length_error@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh76, Lloh77
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev ; -- Begin function _ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev
	.globl	__ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev
	.weak_def_can_be_hidden	__ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev
	.p2align	2
__ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev: ; @_ZNSt3__16vectorIfNS_9allocatorIfEEE20__throw_length_errorB9nqe220100Ev
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh78:
	adrp	x0, l_.str.14@PAGE
Lloh79:
	add	x0, x0, l_.str.14@PAGEOFF
	bl	__ZNSt3__120__throw_length_errorB9nqe220100EPKc
	.loh AdrpAdd	Lloh78, Lloh79
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev ; -- Begin function _ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev
	.globl	__ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev
	.weak_def_can_be_hidden	__ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev
	.p2align	2
__ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev: ; @_ZNSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB9nqe220100Ev
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh80:
	adrp	x0, l_.str.14@PAGE
Lloh81:
	add	x0, x0, l_.str.14@PAGEOFF
	bl	__ZNSt3__120__throw_length_errorB9nqe220100EPKc
	.loh AdrpAdd	Lloh80, Lloh81
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m ; -- Begin function _ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.globl	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak_def_can_be_hidden	__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	2
__ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: ; @_ZNSt3__124__put_character_sequenceB9nqe220100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception3
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x21, x2
	mov	x20, x1
	mov	x19, x0
Ltmp160:                                ; EH_LABEL
	add	x0, sp, #8
	mov	x1, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp161:                                ; EH_LABEL
; %bb.1:
	ldrb	w8, [sp, #8]
	cmp	w8, #1
	b.ne	LBB12_10
; %bb.2:
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x4, x19, x8
	ldr	x22, [x4, #40]
	ldr	w24, [x4, #8]
	ldr	w23, [x4, #144]
	cmn	w23, #1
	b.ne	LBB12_7
; %bb.3:
Ltmp163:                                ; EH_LABEL
	add	x8, sp, #24
	mov	x25, x4
	mov	x0, x4
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp164:                                ; EH_LABEL
; %bb.4:
Ltmp165:                                ; EH_LABEL
Lloh82:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh83:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp166:                                ; EH_LABEL
; %bb.5:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp167:                                ; EH_LABEL
	mov	w1, #32                         ; =0x20
	blr	x8
Ltmp168:                                ; EH_LABEL
; %bb.6:
	mov	x23, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	mov	x4, x25
	str	w23, [x25, #144]
LBB12_7:
	mov	w8, #176                        ; =0xb0
	and	w8, w24, w8
	add	x3, x20, x21
	cmp	w8, #32
	csel	x2, x3, x20, eq
Ltmp170:                                ; EH_LABEL
	sxtb	w5, w23
	mov	x0, x22
	mov	x1, x20
	bl	__ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp171:                                ; EH_LABEL
; %bb.8:
	cbnz	x0, LBB12_10
; %bb.9:
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x0, x19, x8
	ldr	w8, [x0, #32]
	mov	w9, #5                          ; =0x5
Ltmp173:                                ; EH_LABEL
	orr	w1, w8, w9
	bl	__ZNSt3__18ios_base5clearEj
Ltmp174:                                ; EH_LABEL
LBB12_10:
	add	x0, sp, #8
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB12_11:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB12_12:
Ltmp175:                                ; EH_LABEL
	b	LBB12_15
LBB12_13:
Ltmp169:                                ; EH_LABEL
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	b	LBB12_16
LBB12_14:
Ltmp172:                                ; EH_LABEL
LBB12_15:
	mov	x20, x0
LBB12_16:
	add	x0, sp, #8
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
	b	LBB12_18
LBB12_17:
Ltmp162:                                ; EH_LABEL
	mov	x20, x0
LBB12_18:
	mov	x0, x20
	bl	___cxa_begin_catch
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
Ltmp176:                                ; EH_LABEL
	add	x0, x19, x8
	bl	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp177:                                ; EH_LABEL
; %bb.19:
	bl	___cxa_end_catch
	b	LBB12_11
LBB12_20:
Ltmp178:                                ; EH_LABEL
	mov	x19, x0
Ltmp179:                                ; EH_LABEL
	bl	___cxa_end_catch
Ltmp180:                                ; EH_LABEL
; %bb.21:
	mov	x0, x19
	bl	__Unwind_Resume
LBB12_22:
Ltmp181:                                ; EH_LABEL
	bl	___clang_call_terminate
	.loh AdrpLdrGot	Lloh82, Lloh83
Lfunc_end3:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table12:
Lexception3:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase1-Lttbaseref1
Lttbaseref1:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end3-Lcst_begin3
Lcst_begin3:
	.uleb128 Ltmp160-Lfunc_begin3           ; >> Call Site 1 <<
	.uleb128 Ltmp161-Ltmp160                ;   Call between Ltmp160 and Ltmp161
	.uleb128 Ltmp162-Lfunc_begin3           ;     jumps to Ltmp162
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp163-Lfunc_begin3           ; >> Call Site 2 <<
	.uleb128 Ltmp164-Ltmp163                ;   Call between Ltmp163 and Ltmp164
	.uleb128 Ltmp172-Lfunc_begin3           ;     jumps to Ltmp172
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp165-Lfunc_begin3           ; >> Call Site 3 <<
	.uleb128 Ltmp168-Ltmp165                ;   Call between Ltmp165 and Ltmp168
	.uleb128 Ltmp169-Lfunc_begin3           ;     jumps to Ltmp169
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp170-Lfunc_begin3           ; >> Call Site 4 <<
	.uleb128 Ltmp171-Ltmp170                ;   Call between Ltmp170 and Ltmp171
	.uleb128 Ltmp172-Lfunc_begin3           ;     jumps to Ltmp172
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp173-Lfunc_begin3           ; >> Call Site 5 <<
	.uleb128 Ltmp174-Ltmp173                ;   Call between Ltmp173 and Ltmp174
	.uleb128 Ltmp175-Lfunc_begin3           ;     jumps to Ltmp175
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp174-Lfunc_begin3           ; >> Call Site 6 <<
	.uleb128 Ltmp176-Ltmp174                ;   Call between Ltmp174 and Ltmp176
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp176-Lfunc_begin3           ; >> Call Site 7 <<
	.uleb128 Ltmp177-Ltmp176                ;   Call between Ltmp176 and Ltmp177
	.uleb128 Ltmp178-Lfunc_begin3           ;     jumps to Ltmp178
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp177-Lfunc_begin3           ; >> Call Site 8 <<
	.uleb128 Ltmp179-Ltmp177                ;   Call between Ltmp177 and Ltmp179
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp179-Lfunc_begin3           ; >> Call Site 9 <<
	.uleb128 Ltmp180-Ltmp179                ;   Call between Ltmp179 and Ltmp180
	.uleb128 Ltmp181-Lfunc_begin3           ;     jumps to Ltmp181
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp180-Lfunc_begin3           ; >> Call Site 10 <<
	.uleb128 Lfunc_end3-Ltmp180             ;   Call between Ltmp180 and Lfunc_end3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end3:
	.byte	1                               ; >> Action Record 1 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.p2align	2, 0x0
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 1
Lttbase1:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ ; -- Begin function _ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_def_can_be_hidden	__ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	2
__ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ; @_ZNSt3__116__pad_and_outputB9nqe220100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception4
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x0
	cbz	x0, LBB13_16
; %bb.1:
	mov	x24, x5
	mov	x20, x4
	mov	x22, x3
	mov	x21, x2
	mov	x23, x1
	ldr	x25, [x4, #24]
	sub	x26, x2, x1
	cmp	x26, #1
	b.lt	LBB13_3
; %bb.2:
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
	sub	x2, x21, x23
	mov	x0, x19
	mov	x1, x23
	blr	x8
	cmp	x0, x26
	b.ne	LBB13_15
LBB13_3:
	sub	x8, x22, x23
	cmp	x25, x8
	b.le	LBB13_12
; %bb.4:
	mov	x9, #-9                         ; =0xfffffffffffffff7
	movk	x9, #32767, lsl #48
	sub	x23, x25, x8
	cmp	x23, x9
	b.hs	LBB13_17
; %bb.5:
	cmp	x23, #23
	b.hs	LBB13_7
; %bb.6:
	strb	w23, [sp, #31]
	add	x25, sp, #8
	b	LBB13_8
LBB13_7:
	and	x8, x23, #0x7ffffffffffffff8
	add	x8, x8, #8
	mov	w9, #25                         ; =0x19
	cmp	x8, #24
	csel	x26, x9, x8, eq
	mov	x0, x26
	bl	__Znwm
	mov	x25, x0
	orr	x8, x26, #0x8000000000000000
	stp	x0, x23, [sp, #8]
	str	x8, [sp, #24]
LBB13_8:
	mov	x0, x25
	mov	x1, x24
	mov	x2, x23
	bl	_memset
	strb	wzr, [x25, x23]
	ldrsb	w8, [sp, #31]
	ldr	x9, [sp, #8]
	cmp	w8, #0
	add	x8, sp, #8
	csel	x1, x9, x8, mi
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
Ltmp182:                                ; EH_LABEL
	mov	x0, x19
	mov	x2, x23
	blr	x8
Ltmp183:                                ; EH_LABEL
; %bb.9:
	ldrsb	w8, [sp, #31]
	tbnz	w8, #31, LBB13_11
; %bb.10:
	cmp	x0, x23
	b.ne	LBB13_15
	b	LBB13_12
LBB13_11:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	and	x1, x9, #0x7fffffffffffffff
	mov	x24, x0
	mov	x0, x8
	bl	__ZdlPvm
	cmp	x24, x23
	b.ne	LBB13_15
LBB13_12:
	sub	x22, x22, x21
	cmp	x22, #1
	b.lt	LBB13_14
; %bb.13:
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
	mov	x0, x19
	mov	x1, x21
	mov	x2, x22
	blr	x8
	cmp	x0, x22
	b.ne	LBB13_15
LBB13_14:
	str	xzr, [x20, #24]
	b	LBB13_16
LBB13_15:
	mov	x19, #0                         ; =0x0
LBB13_16:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB13_17:
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB9nqe220100Ev
LBB13_18:
Ltmp184:                                ; EH_LABEL
	mov	x19, x0
	ldrsb	w8, [sp, #31]
	tbz	w8, #31, LBB13_20
; %bb.19:
	ldr	x0, [sp, #8]
	ldr	x8, [sp, #24]
	and	x1, x8, #0x7fffffffffffffff
	bl	__ZdlPvm
LBB13_20:
	mov	x0, x19
	bl	__Unwind_Resume
Lfunc_end4:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table13:
Lexception4:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end4-Lcst_begin4
Lcst_begin4:
	.uleb128 Lfunc_begin4-Lfunc_begin4      ; >> Call Site 1 <<
	.uleb128 Ltmp182-Lfunc_begin4           ;   Call between Lfunc_begin4 and Ltmp182
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp182-Lfunc_begin4           ; >> Call Site 2 <<
	.uleb128 Ltmp183-Ltmp182                ;   Call between Ltmp182 and Ltmp183
	.uleb128 Ltmp184-Lfunc_begin4           ;     jumps to Ltmp184
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp183-Lfunc_begin4           ; >> Call Site 3 <<
	.uleb128 Lfunc_end4-Ltmp183             ;   Call between Ltmp183 and Lfunc_end4
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end4:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE ; -- Begin function _ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE
	.globl	__ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE
	.weak_def_can_be_hidden	__ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE
	.p2align	2
__ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE: ; @_ZNSt3__125__independent_bits_engineINS_23mersenne_twister_engineIjLm32ELm624ELm397ELm31ELj2567483615ELm11ELj4294967295ELm7ELj2636928640ELm15ELj4022730752ELm18ELj1812433253EEEmE6__evalENS_17integral_constantIbLb1EEE
	.cfi_startproc
; %bb.0:
	mov	w9, #-272236544                 ; =0xefc60000
	mov	w10, #22144                     ; =0x5680
	movk	w10, #40236, lsl #16
	mov	w11, #45279                     ; =0xb0df
	movk	w11, #39176, lsl #16
	ldr	x12, [x0, #32]
	cbz	x12, LBB14_5
; %bb.1:
	ldr	x13, [x0]
	ldr	x14, [x0, #40]
	ldr	x16, [x0, #16]
	ldr	x15, [x13, #2496]
	cmp	x16, #64
	b.hs	LBB14_7
; %bb.2:
	mov	x8, #0                          ; =0x0
	mov	x17, #0                         ; =0x0
	mov	x1, #3361                       ; =0xd21
	movk	x1, #8402, lsl #16
	movk	x1, #53773, lsl #32
	movk	x1, #3360, lsl #48
	mov	w2, #624                        ; =0x270
LBB14_3:                                ; =>This Inner Loop Header: Depth=1
	mov	x3, x15
	add	x15, x15, #1
	lsr	x4, x15, #4
	umulh	x4, x4, x1
	lsr	x4, x4, #1
	msub	x15, x4, x2, x15
	ldr	w4, [x13, x3, lsl #2]
	and	w4, w4, #0x80000000
	ldr	w5, [x13, x15, lsl #2]
	and	w6, w5, #0x7ffffffe
	orr	w4, w6, w4
	add	x6, x3, #397
	lsr	x7, x6, #4
	umulh	x7, x7, x1
	lsr	x7, x7, #1
	msub	x6, x7, x2, x6
	ldr	w6, [x13, x6, lsl #2]
	tst	w5, #0x1
	csel	w5, w11, wzr, ne
	eor	w5, w5, w6
	eor	w4, w5, w4, lsr #1
	str	w4, [x13, x3, lsl #2]
	eor	w3, w4, w4, lsr #11
	and	w4, w10, w3, lsl #7
	eor	w3, w4, w3
	and	w4, w9, w3, lsl #15
	eor	w3, w4, w3
	eor	w3, w3, w3, lsr #18
	cmp	x14, x3
	b.ls	LBB14_3
; %bb.4:                                ;   in Loop: Header=BB14_3 Depth=1
	lsl	x8, x8, x16
	ldr	w4, [x0, #56]
	and	w3, w4, w3
	add	x8, x8, x3
	add	x17, x17, #1
	cmp	x17, x12
	b.ne	LBB14_3
	b	LBB14_11
LBB14_5:
	mov	x8, #0                          ; =0x0
	ldr	x14, [x0, #24]
	cmp	x12, x14
	b.lo	LBB14_12
LBB14_6:
	mov	x0, x8
	ret
LBB14_7:
	mov	x8, #0                          ; =0x0
	mov	x16, #3361                      ; =0xd21
	movk	x16, #8402, lsl #16
	movk	x16, #53773, lsl #32
	movk	x16, #3360, lsl #48
	mov	w17, #624                       ; =0x270
LBB14_8:                                ; =>This Inner Loop Header: Depth=1
	mov	x1, x15
	add	x15, x15, #1
	lsr	x2, x15, #4
	umulh	x2, x2, x16
	lsr	x2, x2, #1
	msub	x15, x2, x17, x15
	ldr	w2, [x13, x1, lsl #2]
	and	w2, w2, #0x80000000
	ldr	w3, [x13, x15, lsl #2]
	and	w4, w3, #0x7ffffffe
	orr	w2, w4, w2
	add	x4, x1, #397
	lsr	x5, x4, #4
	umulh	x5, x5, x16
	lsr	x5, x5, #1
	msub	x4, x5, x17, x4
	ldr	w4, [x13, x4, lsl #2]
	tst	w3, #0x1
	csel	w3, w11, wzr, ne
	eor	w3, w3, w4
	eor	w2, w3, w2, lsr #1
	str	w2, [x13, x1, lsl #2]
	eor	w1, w2, w2, lsr #11
	and	w2, w10, w1, lsl #7
	eor	w1, w2, w1
	and	w2, w9, w1, lsl #15
	eor	w1, w2, w1
	eor	w1, w1, w1, lsr #18
	cmp	x14, x1
	b.ls	LBB14_8
; %bb.9:                                ;   in Loop: Header=BB14_8 Depth=1
	add	x8, x8, #1
	cmp	x8, x12
	b.ne	LBB14_8
; %bb.10:
	ldr	w8, [x0, #56]
	and	w8, w8, w1
LBB14_11:
	str	x15, [x13, #2496]
	ldr	x14, [x0, #24]
	cmp	x12, x14
	b.hs	LBB14_6
LBB14_12:
	ldr	x13, [x0]
	ldr	x15, [x0, #48]
	ldr	x17, [x0, #16]
	ldr	x16, [x13, #2496]
	cmp	x17, #63
	b.hs	LBB14_17
; %bb.13:
	add	x17, x17, #1
	mov	x1, #3361                       ; =0xd21
	movk	x1, #8402, lsl #16
	movk	x1, #53773, lsl #32
	movk	x1, #3360, lsl #48
	mov	w2, #624                        ; =0x270
LBB14_14:                               ; =>This Inner Loop Header: Depth=1
	mov	x3, x16
	add	x16, x16, #1
	lsr	x4, x16, #4
	umulh	x4, x4, x1
	lsr	x4, x4, #1
	msub	x16, x4, x2, x16
	ldr	w4, [x13, x3, lsl #2]
	and	w4, w4, #0x80000000
	ldr	w5, [x13, x16, lsl #2]
	and	w6, w5, #0x7ffffffe
	orr	w4, w6, w4
	add	x6, x3, #397
	lsr	x7, x6, #4
	umulh	x7, x7, x1
	lsr	x7, x7, #1
	msub	x6, x7, x2, x6
	ldr	w6, [x13, x6, lsl #2]
	tst	w5, #0x1
	csel	w5, w11, wzr, ne
	eor	w5, w5, w6
	eor	w4, w5, w4, lsr #1
	str	w4, [x13, x3, lsl #2]
	eor	w3, w4, w4, lsr #11
	and	w4, w10, w3, lsl #7
	eor	w3, w4, w3
	and	w4, w9, w3, lsl #15
	eor	w3, w4, w3
	eor	w3, w3, w3, lsr #18
	cmp	x15, x3
	b.ls	LBB14_14
; %bb.15:                               ;   in Loop: Header=BB14_14 Depth=1
	lsl	x8, x8, x17
	ldr	w4, [x0, #60]
	and	w3, w4, w3
	add	x8, x8, x3
	add	x12, x12, #1
	cmp	x12, x14
	b.ne	LBB14_14
; %bb.16:
	str	x16, [x13, #2496]
	mov	x0, x8
	ret
LBB14_17:
	mov	x8, #3361                       ; =0xd21
	movk	x8, #8402, lsl #16
	movk	x8, #53773, lsl #32
	movk	x8, #3360, lsl #48
	mov	w17, #624                       ; =0x270
LBB14_18:                               ; =>This Inner Loop Header: Depth=1
	mov	x1, x16
	add	x16, x16, #1
	lsr	x2, x16, #4
	umulh	x2, x2, x8
	lsr	x2, x2, #1
	msub	x16, x2, x17, x16
	ldr	w2, [x13, x1, lsl #2]
	and	w2, w2, #0x80000000
	ldr	w3, [x13, x16, lsl #2]
	and	w4, w3, #0x7ffffffe
	orr	w2, w4, w2
	add	x4, x1, #397
	lsr	x5, x4, #4
	umulh	x5, x5, x8
	lsr	x5, x5, #1
	msub	x4, x5, x17, x4
	ldr	w4, [x13, x4, lsl #2]
	tst	w3, #0x1
	csel	w3, w11, wzr, ne
	eor	w3, w3, w4
	eor	w2, w3, w2, lsr #1
	str	w2, [x13, x1, lsl #2]
	eor	w1, w2, w2, lsr #11
	and	w2, w10, w1, lsl #7
	eor	w1, w2, w1
	and	w2, w9, w1, lsl #15
	eor	w1, w2, w1
	eor	w1, w1, w1, lsr #18
	cmp	x15, x1
	b.ls	LBB14_18
; %bb.19:                               ;   in Loop: Header=BB14_18 Depth=1
	add	x12, x12, #1
	cmp	x12, x14
	b.ne	LBB14_18
; %bb.20:
	ldr	w8, [x0, #60]
	and	w8, w8, w1
	str	x16, [x13, #2496]
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Usage: benchmark S H D head trials target_ms seed"

l_.str.1:                               ; @.str.1
	.asciz	"Dimensions, trials, target_ms must be positive; head < H"

l_.str.2:                               ; @.str.2
	.asciz	"Shape overflow"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @__const.main.kernels
l___const.main.kernels:
	.quad	__Z3dotIL6Layout0EEvPKfS2_Pfmmmm
	.quad	__Z3dotIL6Layout1EEvPKfS2_Pfmmmm
	.quad	__Z3dotIL6Layout2EEvPKfS2_Pfmmmm

	.section	__TEXT,__cstring,cstring_literals
l_.str.3:                               ; @.str.3
	.asciz	"SHD"

l_.str.4:                               ; @.str.4
	.asciz	"HSD"

l_.str.5:                               ; @.str.5
	.asciz	"DSH"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @__const.main.names
l___const.main.names:
	.quad	l_.str.3
	.quad	l_.str.4
	.quad	l_.str.5

	.section	__TEXT,__cstring,cstring_literals
l_.str.6:                               ; @.str.6
	.asciz	"validation failed:"

	.section	__TEXT,__const
	.p2align	3, 0x0                          ; @__const.main.iterations
l___const.main.iterations:
	.quad	1                               ; 0x1
	.quad	1                               ; 0x1
	.quad	1                               ; 0x1

	.section	__TEXT,__cstring,cstring_literals
l_.str.7:                               ; @.str.7
	.asciz	"Iteration overflow"

l_.str.8:                               ; @.str.8
	.asciz	"layout,S,H,D,head_start,heads_processed,trial,iterations,ns_per_call,max_abs_error,seed,cache_mode\n"

l_.str.9:                               ; @.str.9
	.asciz	",1,"

l_.str.10:                              ; @.str.10
	.asciz	",repeated_buffer\n"

l_.str.11:                              ; @.str.11
	.asciz	"Invalid integer"

l_.str.12:                              ; @.str.12
	.asciz	"Invalid Integer"

l_.str.13:                              ; @.str.13
	.asciz	"basic_string"

l_.str.14:                              ; @.str.14
	.asciz	"vector"

.subsections_via_symbols
