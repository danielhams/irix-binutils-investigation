	.file	1	"/usr/people/dan/Sources/GitClones/irix-binutils-investigation.git/simple.c"
	.set	noreorder
	.set	noat
	#  /usr/lib32/cmplrs/be::7.44

	#-----------------------------------------------------------
	# Compiling simple.c (/tmp/ctmB.BAAa00TbF)
	#-----------------------------------------------------------

	#-----------------------------------------------------------
	# Options:
	#-----------------------------------------------------------
	#  Target:R10000, ISA:mips4, Pointer Size:32
	#  -O1	(Optimization level)
	#  -g0	(Debug level)
	#  -m1	(Report warnings)
	#-----------------------------------------------------------


	.section .text, 1, 0x00000006, 4, 16
.text:

	.section .rodata, 1, 0x00000002, 0, 8
.rodata:
	.section .text

	# Program Unit: main
	.ent	main
	.globl	main
main:	# 0x0
	.dynsym	main	sto_default
	.frame	$sp, 48, $31
	.mask	0x80000000, -40
	# a = 0
	# lcl_spill_temp_0 = 8
	# lcl_spill_temp_1 = 16
	.loc	1 4 1
 #   1  #include <stdio.h>
 #   2  
 #   3  int main(int argc, char**argv)
 #   4  {
.BB1.main:	# 0x0
	.type	main, stt_func
	lui $6,%hi(%neg(%gp_rel(main)))	# [0]  main
	addiu $6,$6,%lo(%neg(%gp_rel(main)))	# [1]  main
	addiu $sp,$sp,-48             	# [0]  
	sd $gp,16($sp)                	# [1]  lcl_spill_temp_1
	addu $gp,$25,$6               	# [2]  
	.loc	1 5 3
 #   5    printf("Hello %lu\n", sizeof(char));
	.type	printf, stt_func
	lw $25,%call16(printf)($gp)   	# [3]  printf
	.loc	1 4 1
	sw $4,36($sp)                 	# [2]  argc
	.loc	1 5 3
	lw $4,%got_page(.rodata)($gp) 	# [4]  .rodata
	.loc	1 4 1
	sw $5,44($sp)                 	# [5]  argv
	.loc	1 5 3
	addiu $5,$0,1                 	# [2]  
	.loc	1 4 1
	sd $31,8($sp)                 	# [6]  lcl_spill_temp_0
	.loc	1 5 3
	jalr $25                      	# [5]  printf
	addiu $4,$4,%got_ofst(.rodata)	# [6]  .rodata
.BB2.main:	# 0x34
	.loc	1 7 3
 #   6    int a=0;
 #   7    return a;
	ld $31,8($sp)                 	# [0]  lcl_spill_temp_0
	.loc	1 6 7
	sw $0,0($sp)                  	# [1]  a
	.loc	1 7 3
	ld $gp,16($sp)                	# [2]  lcl_spill_temp_1
	lw $2,0($sp)                  	# [3]  a
	jr $31                        	# [2]  
	addiu $sp,$sp,48              	# [1]  
	.end	main

	.section .rodata
	.origin 0x0
	.align	0
	# offset 0
	.byte	0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x25, 0x6c	# Hello %l
	.byte	0x75, 0xa, 0x0	# u\n\000
	.section .text
	.align 4
	.section .rodata
	.align 3
	.gpvalue 30720
