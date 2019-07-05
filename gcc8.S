	.file	1 "simple.c"
	.section .mdebug.abiN32
	.previous
	.gnu_attribute 4, 1
	.abicalls
	.text
 #APP
	.ident	"$Revision: 1.13 $"

	.ident	"$Id: standards.h,v 1.22 2002/08/07 14:51:48 raji Exp $"

	.ident	"$Revision: 1.11 $"

	.ident	"$Revision: 1.13 $"

	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.ascii	"Hello %lu\012\000"
 #NO_APP
	.text
	.align	2
	.globl	main
.LFB0 = .
	.set	nomips16
	.ent	main
	.type	main, @function
main:
	.frame	$sp,16,$31		# vars= 0, regs= 2/0, args= 0, gp= 0
	.mask	0x90000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
.LCFI0 = .
	sd	$31,8($sp)
	sd	$28,0($sp)
.LCFI1 = .
	lui	$28,%hi(%neg(%gp_rel(main)))
	addu	$28,$28,$25
	addiu	$28,$28,%lo(%neg(%gp_rel(main)))
	li	$5,1			# 0x1
	lw	$4,%got_page(.LC0)($28)
	lw	$25,%call16(printf)($28)
	jalr	$25
	addiu	$4,$4,%got_ofst(.LC0)

	move	$2,$0
	ld	$31,8($sp)
	ld	$28,0($sp)
	jr	$31
	addiu	$sp,$sp,16

.LCFI2 = .
	.set	macro
	.set	reorder
	.end	main
.LFE0:
	.size	main, .-main
	.section	.debug_frame,"",@progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 -4
	.byte	0x40
	.byte	0xc
	.uleb128 0x1d
	.uleb128 0
	.byte	0x9
	.uleb128 0x40
	.uleb128 0x1f
	.align	2
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x9f
	.uleb128 0x2
	.byte	0x9c
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0
	.byte	0xdc
	.byte	0xdf
	.align	2
.LEFDE0:
	.align	0
	.ident	"GCC: (GNU) 8.2.0"
