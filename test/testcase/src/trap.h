#ifndef __TRAP_H__
#define __TRAP_H__

#define concat_temp(x, y) x ## y
#define concat(x, y) concat_temp(x, y)

#define HIT_GOOD_TRAP\
	do{\
		asm volatile("add $31, $0, 0x56788765\n\t"\
				"suc:\n\t"\
				"j suc\n\t"\
				"nop\n\t");\
	}while(0)

int main();

__attribute__((noinline))
void _reset()
{
	asm volatile("addi $29, $0, 0x1f00\n\t"
			"j main\n\t");
}

__attribute__((noinline))
void nemu_assert(int cond) 
{
	do{
		if( !cond )
			asm volatile("add $31, $0, 0x12344321\n\t"\
				"fail:\n\t"\
				"j fail\n\t"\
				"nop\n\t");
	}while(0);
}

#endif
