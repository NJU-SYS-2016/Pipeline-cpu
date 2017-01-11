#include "trap.h"

short sh[2];
unsigned us[2];

int main()
{
	sh[0] = 0x1234;
	sh[1] = 0xf321;
	us[0] = 0x6789;
	us[1] = 0x8765;
	
	int i = sh[0];
	nemu_assert(i==0x1234);
	i = sh[1];
	nemu_assert(i==0xfffff321);
	i = us[0];
	nemu_assert(i==0x6789);
	i = us[1];
	nemu_assert(i==0x8765);
	
	HIT_GOOD_TRAP;
	
	return 0;
}