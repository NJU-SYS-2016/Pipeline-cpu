.text
.globl _reset   
.set noat
.set noreorder

#the program excutes without error, then $gp will be set 1,  otherwise 0
#please check valule of $gp in your simulation wave window


_reset:
	//测试cp0正常读写MTC0/MFC0。转发未进行实现因此不对转发进行测试
	//测试cp0时钟中断产生
	//最终测试通过情况：$26为3，time_i变为1后持续一段时间变0，最后变为1后不变化

	//注意：仿真时间需要较长，建议10000ns左右

	//#1, 测试mfc0
	li		$26, 1
	mfc0	$7, $12
	li		$8, 0x1000ff01
	nop
	bne		$7, $8, trap
	
	//#2, 测试mtc0
	li		$26, 2
	mfc0	$7, $9
	nop
	nop
	addiu	$8, $7, 100
	nop
	nop
	mtc0	$8, $11
	
	//#3,测试时钟中断关闭与产生
	li		$4, 100
	li		$7, 1
loop:
	sub		$4, $4, $7
	bne		$4, $0, loop
	li		$26, 3
	mfc0	$7, $9
	nop
	nop
	addiu	$8, $7, 50
	nop
	nop
	mtc0	$8, $11
	

trap:
	b trap
