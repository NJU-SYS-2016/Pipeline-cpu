# mul 45 12
li $26, 1			// 26号寄存器用来表明当前处于第几个测试用例
li $7, 45			// 加载第一个操作数
li $8, 12			// 加载第二个操作数
mul $12, $7, $8		// 测试指令
li $9, 540			// 乘法运算的正确结果 
bne $9, $12, trap	// 判断指令运行结果是否正确
nop					// branch指令导致流水线阻塞

# mul 0x80000000 2
li $26, 2
li $7, 0x80000000
li $8, 2
mul $12, $7, $8
li $9, 0 
bne $9, $12, trap
nop

# mul 0x7fffffff 3
li $26, 3
li $7, 0x7fffffff
li $8, 3
mul $12, $7, $8
li $9, 0x7ffffffd
bne $9, $12, trap
nop


# mult 4 33
li $26, 4
li $7, 4
li $8, 33
mult $7, $8
li $9, 132
mflo $10
bne $9, $10, trap
nop
li $9, 0
mfhi $10
bne $9, $10, trap
nop

# mult 0x70000001 13
li $26, 5
li $7, 0x70000001
li $8, 13
mult $7, $8
li $9, 0xb000000d
mflo $10
bne $9, $10, trap
nop
li $9, 5
mfhi $10
bne $9, $10, trap
nop

# mult 0x80000000 3
li $26, 6
li $7, 0x80000000
li $8, 3
mult $7, $8
li $9, 0x80000000
mflo $10
bne $9, $10, trap
nop
li $9, 0xfffffffe
mfhi $10
bne $9, $10, trap
nop

# mult 0xfffffffd 9
li $26, 7
li $7, 0xfffffffd
li $8, 9
mult $7, $8
li $9, 0xffffffe5
mflo $10
bne $9, $10, trap
nop
li $9, 0xffffffff
mfhi $10
bne $9, $10, trap
nop

# multu 1 88
li $26, 8
li $7, 1
li $8, 88
multu $7, $8
li $9, 88
mflo $10
bne $9, $10, trap
nop
li $9, 0
mfhi $10
bne $9, $10, trap
nop

# multu 0xfffffffe 8
li $26, 9
li $7, 0xfffffffe
li $8, 8
multu $7, $8
li $9, 0xfffffff0
mflo $10
bne $9, $10, trap
nop
li $9, 7
mfhi $10
bne $9, $10, trap
nop


# div 44 4
li $26, 10
li $7, 44
li $8, 4
div $7, $8
li $9, 11
mflo $10
bne $9, $10, trap
nop
li $9, 0
mfhi $10
bne $9, $10, trap
nop

# div 32 -5
li $26, 11
li $7, 32
li $8, -5
div $7, $8
li $9, -6
mflo $10
bne $9, $10, trap
nop
li $9, 2
mfhi $10
bne $9, $10, trap
nop

# div 22 0

# div 0x80000000 -1
li $26, 12
li $7, 0x80000000
li $8, -1
div $7, $8
li $9, 0x80000000
mflo $10
bne $9, $10, trap
nop
li $9, 0
mfhi $10
bne $9, $10, trap
nop

# divu 39 3
li $26, 13
li $7, 39
li $8, 3
div $7, $8
li $9, 13
mflo $10
bne $9, $10, trap
nop
li $9, 0
mfhi $10
bne $9, $10, trap
nop

# divu 0x80000000 0xffffffff
li $26, 14
li $7, 0x80000000
li $8, 0xffffffff
divu $7, $8
li $9, 0
mflo $10
bne $9, $10, trap
nop
li $9, 0x80000000
mfhi $10
bne $9, $10, trap
nop

# divu 0xfffffffe 2
li $26, 15
li $7, 0xfffffffe
li $8, 2
divu $7, $8
li $9, 0x7fffffff
mflo $10
bne $9, $10, trap
nop
li $9, 0
mfhi $10
bne $9, $10, trap
nop


# mthi $31
li $26, 16
li $7, 0x80000000
mthi $7
mfhi $8
bne $7, $8, trap
nop

# mtlo $0
li $26, 17
li $7, 0x88
mtlo $7
mflo $8
bne $7, $8, trap
nop

li $26, 18

trap:
nop
j trap
