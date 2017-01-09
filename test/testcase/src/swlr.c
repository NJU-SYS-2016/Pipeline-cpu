#include "trap.h"

int main()
{
	asm volatile("lui $2, 0x1234\n\t"\
			"ori $2, $2, 0x5678\n\t"\
			"lui $3, 0xabcd\n\t"\
			"ori $3, $3, 0xef19\n\t"\
			"sw $3, 0xf00($0)\n\t"\
			"swl $2, 0xf00($0)\n\t"
			"lw $4, 0xf00($0)\n\t"\
			"sw $3, 0xf00($0)\n\t"\
			"swl $2, 0xf01($0)\n\t"\
			"lw $4, 0xf00($0)\n\t"\
			"sw $3, 0xf00($0)\n\t"\
            "swl $2, 0xf02($0)\n\t"\
            "lw $4, 0xf00($0)\n\t"\
			"sw $3, 0xf00($0)\n\t"\
            "swl $2, 0xf03($0)\n\t"\
            "lw $4, 0xf00($0)\n\t"\
\
			"sw $3, 0xf00($0)\n\t"\
            "swr $2, 0xf00($0)\n\t"\
            "lw $4, 0xf00($0)\n\t"\
			"sw $3, 0xf00($0)\n\t"\
            "swr $2, 0xf01($0)\n\t"\
            "lw $4, 0xf00($0)\n\t"\
			"sw $3, 0xf00($0)\n\t"\
            "swr $2, 0xf02($0)\n\t"\
            "lw $4, 0xf00($0)\n\t"\
			"sw $3, 0xf00($0)\n\t"\
            "swr $2, 0xf03($0)\n\t"\
            "lw $4, 0xf00($0)\n\t"\
			);

	HIT_GOOD_TRAP;
	return 0;
}
