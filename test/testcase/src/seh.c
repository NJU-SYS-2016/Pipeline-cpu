#include "trap.h"

__attribute__((noinline))
int f(short i)
{
	return i;
}

int main()
{
	int i = f(0x8010);
	nemu_assert(i==0xffff8010);
	i = f(0x1234);
	nemu_assert(i==0x1234);
	
	HIT_GOOD_TRAP;
	return 0;
}
