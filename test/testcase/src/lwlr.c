#include "trap.h"

int main()
{
	asm volatile("lui $2, 0xabcd\n\t"\
			"ori $2, $2, 0xef19\n\t"\
			"sw $2, 0xf00($0)\n\t"\
			"lui $3, 0x1234\n\t"\
			"ori $3, $3, 0x5678\n\t"\
			"or $4, $0, $3\n\t"\
			"lwl $4, 0xf00($0)\n\t"\
			"or $4, $0, $3\n\t"\
            "lwl $4, 0xf01($0)\n\t"\
			"or $4, $0, $3\n\t"\
            "lwl $4, 0xf02($0)\n\t"\
			"or $4, $0, $3\n\t"\
            "lwl $4, 0xf03($0)\n\t"\
\
			"or $4, $0, $3\n\t"\
            "lwr $4, 0xf00($0)\n\t"\
			"or $4, $0, $3\n\t"\
            "lwr $4, 0xf01($0)\n\t"\
			"or $4, $0, $3\n\t"\
            "lwr $4, 0xf02($0)\n\t"\
			"or $4, $0, $3\n\t"\
            "lwr $4, 0xf03($0)\n\t" );
}
