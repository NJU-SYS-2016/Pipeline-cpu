.text
.globl _reset   
.set noat
.set noreorder

#the program excutes without error, then $gp will be set 1,  otherwise 0
#please check valule of $gp in your simulation wave window


_reset:
	//注意1：在此处测试中，为了简便，需要修改部分电路，修改如下
	//异常以及中断跳转地址改为pc+12，用于测试异常中断是否正常跳转
	//测试完成后需要将改地址改回原来的异常跳转

	//注意2：17号测试无效指令异常，需要直接在二进制代码中进行修改

	//测试通过标志：$31, $30, $26 均为18(0x12)
	//寄存器说明：$31记录错误测试编号,$26记录正在测试的编号,$30测试通过则赋值,$8/$7计算使用寄存器

	//自陷指令测试	
	//#1 测试teq，
	li $26, 1
    li $7, 0x12345678
    li $8, 0x12345678
    teq $7, $8
	li	$31, 1
	j	trap
	
	//#2，测试teqi
	li	$26, 2
	//li	$7, 0xffffba13
	addi	$7, $0, 0xba13
	teqi $7, 0xba13
	li	$31, 2
	j	trap
	
	//#3， 测试tge
	li	$26, 3
	li	$7, 0x12abb111
	li	$8, 0x2aaabbb
	tge	$7, $8
	li	$31, 3
	j 	trap
	
	//#4， 测试tgei
	li	$26, 4
	li	$7, 0x12abb111
	tgei	$7, 0xffff
	li	$31, 4
	j 	trap
	
	//#5， 测试tgeu
	li	$26, 5
	li	$7, 0xffabb111
	li	$8, 0x11222433
	tgeu	$7, $8
	li	$31, 5
	j 	trap

	//#6， 测试tgeiu
	li	$26, 6
	li	$7, 0xffabb111
	tgeiu	$7, 0x1234
	li	$31, 6
	j 	trap

	//#7，测试tlt
	li	$26, 7
	li	$7, 0x123b1231
	li	$8, 0x56612333
	tlt	$7, $8
	li	$31, 7
	j	trap
	
	//#8，测试tlti
	li	$26, 8
	li	$7, 0xff122223
	tlti	$7, 0x1222
	li	$31, 8
	j	trap

	//#9, 测试tltu
	li	$26, 9
	li	$7, 0x12213123
	li	$8, 0xff122244
	tltu $7, $8
	li	$31, 9
	j	trap

	//#10，测试tltiu
	li	$26, 10
	li	$7, 0x13242141
	tltiu $7, 0xffff
	li	$31, 10
	j	trap

	//#11，测试tne
	li	$26, 11
	li	$7, 0x123abc77
	li	$8, 0x123abc76
	tne	$7, $8
	li	$31, 11
	j	trap

	//#12，测试tnei
	li	$26, 12
	li	$7, 0xffffab11
	tnei	$7, 0xab12
	li	$31, 12
	j	trap

	//#13，测试syscall
	li $26, 13
	syscall
	li	$31, 13
	j	trap

	//测试overflow
	//#14，测试add
	li	$26, 14
	li	$7, 0x7f134421
	li	$8, 0x7fab1231
	add	$7, $7, $8
	li	$31, 14
	j	trap
	
	//#15, 测试addi
	li	$26, 15
	li	$7, 0x7fffffff
	addi	$7, 0x7fff
	li	$31, 15
	j	trap

	//#16，测试sub
	li	$26, 16
	li	$7, 0x80000000
	li	$8, 0x11231231
	sub	$7, $8
	li	$31, 16
	j	trap
	
	//#17，测试无效指令，汇编后需要对照反汇编代码在会产生异常的代码中修改
	//此处修改sub $7, $8对应二进制代码
	//原测试是将ram.txt中0x6f指令，对应于code.txt的0x1bc处的指令sub a3,a3,t0(0x00e83822)
	//修改为0xfd000000
	li	$26, 17
	li	$7, 0x80000000
	li	$8, 0x11231231
	sub	$7, $8
	li	$31, 17
	j	trap
	
	//#18，测试eret
	li	$26, 18
	li	$30, 18
	li	$7, 0x80000000
	li	$8, 0x11231231
	sub	$7, $8
	li	$31, 18
	j	trap

	li	$7, 0x14213421
	li	$8, 0x11231231
	eret

trap:
	b trap
