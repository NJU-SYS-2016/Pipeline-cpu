#include <stdio.h>
#include <string.h>
#include <assert.h>

typedef struct item {
	char *name;
	int bits;
} item;

item table[] = {	{ "idex_cp0_src_addr", 5 },
					{ "idex_jump", 1 },
					{ "idex_mem_w_en", 1 },
					{ "idex_mem_r_en", 1 },
					{ "idex_reg_w_en", 1 },
					{ "idex_branch", 1 },
					{ "idex_condition", 3 },
					{ "idex_B_sel", 1 },
					{ "idex_ALU_op", 4 },
					{ "idex_shamt", 5 },
					{ "idex_shamt_sel", 1 },
					{ "idex_shift_op", 2 },
					{ "idex_load_sel", 3 },
					{ "idex_store_sel", 3 },
					{ "idex_of_w_disen", 1 },
					{ "idex_cp0_dest_addr", 5 },
					{ "idex_cp0_w_en", 1 },
					{ "idex_syscall", 1 },
					{ "idex_eret", 1 },
					{ "idex_jr", 1 },
					{ "idex_exres_sel", 3 },
					{ "idex_movn", 1 },
					{ "idex_movz", 1 },
					{ "idex_rt_data_sel", 1 },
					{ "idex_imm_ext", 2 },
					{ "idex_rd_addr_sel", 2 },
					{ "idex_rt_addr_sel", 1 },
					{ "idex_invalid", 1 },
					{ "idex_trap", 1 },
					{ "idex_md_op", 4 },
					{ "idex_nop", 1 },
				};


int main()
{
	FILE *fp = fopen("decoder_table.txt", "r");
	FILE *frame_fp = fopen("decoder_frame.v", "r");
	assert(fp);
	assert(frame_fp);

	char line[4096];
	int k;
	for(k = 0; k < 57; k ++) {
		fgets(line, 4096, frame_fp);
		printf("%s", line);
	}

	char buf[4096];
	while(fgets(buf, 4096, fp)) {
		int i = 0;
		char *p = strtok(buf, ",");
		//printf("\t\tend else if((ifid_instr[31 : 26] == 6'b000000) &&\n");
		//printf("\t\t\t(ifid_instr[5 : 0] == 6'b000000)) begin\n");
		fgets(line, 4096, frame_fp);
		while(line[0] != '\n') {
			printf("%s", line);
			fgets(line, 4096, frame_fp);
		}
		p = strtok(NULL, ",");
		while(p) {
			//if(i == 30) p[2] = '\0';
			// Reset '\n' to '\0'
			if(i == (sizeof(table) / sizeof(table[0]) - 1))
				p[table[i].bits + 1] = '\0';
			if(strlen(p) > 1) {
				printf("\t\t\t\t%s = %d'b%s;\n", table[i].name, table[i].bits, p + 1);
			} else {
				// default value
				printf("\t\t\t\t%s = %d'b%.*d;\n", table[i].name, table[i].bits, table[i].bits, 0);
			}
			i ++;
			p = strtok(NULL, ",");
		}

		printf("\n");
		assert(i == (sizeof(table) / sizeof(table[0])));
	}

	while(!feof(frame_fp)) {
		fgets(line, 4096, frame_fp);
		printf("%s", line);
	}

	fclose(fp);
	fclose(frame_fp);

	return 0;
}
