`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2016/12/09 19:19:00
// Author: Zheng Bin
// Module Name: decoder
// Project Name: Pipeline CPU
// Verion: 2.0
// Tool Versions: vivado 2016.2
//////////////////////////////////////////////////////////////////////////////////

module decoder(
	input [31 : 0]						ifid_instr,
	
	// enable or disenable
	output reg							idex_mem_w_en,
	output reg							idex_mem_r_en,
	output reg							idex_reg_w_en,
	output reg							idex_of_w_disen,
	output reg							idex_cp0_w_en,
	
	// others
	output reg							idex_jump,
	output reg							idex_branch,
	output reg [2 : 0]					idex_condition,
	output reg [4 : 0]					idex_shamt,
	output reg [1 : 0]					idex_imm_ext,
	
	// opcode
	output reg [3 : 0]					idex_ALU_op, 
	output reg [1 : 0]					idex_shift_op,
	output reg [3 : 0]					idex_md_op,
	
	// specific instruction
	output reg							idex_syscall,
	output reg							idex_eret,
	output reg							idex_jr,
	output reg							idex_movn,
	output reg							idex_movz,
	output reg							idex_nop,
	output reg							idex_trap,
	output reg							idex_invalid,
	
	// selection
	output reg							idex_B_sel,
	output reg							idex_shamt_sel,
	output reg [2 : 0]					idex_load_sel,
	output reg [2 : 0]					idex_store_sel,  
	output reg [2 : 0]					idex_exres_sel,
	output reg							idex_rt_data_sel,
	output reg [1 : 0]					idex_rd_addr_sel,
	output reg							idex_rt_addr_sel,
	
	// register addr
	output reg [4 : 0]					idex_cp0_src_addr,
	output reg [4 : 0]					idex_cp0_dest_addr
	);

	always @ (ifid_instr) begin
		// ADD
		if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100000)) begin

		// ADDU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100001)) begin

		// ADDI
		end else if(ifid_instr[31 : 26] == 6'b001000) begin

		// ADDIU
		end else if(ifid_instr[31 : 26] == 6'b001001) begin

		// SUB
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100010)) begin

		// SUBU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100011)) begin

		// AND
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100100)) begin

		// ANDI
		end else if(ifid_instr[31 : 26] == 6'b001100) begin

		// OR
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100101)) begin

		// ORI
		end else if(ifid_instr[31 : 26] == 6'b001101) begin

		// XOR
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100110)) begin

		// XORI
		end else if(ifid_instr[31 : 26] == 6'b001110) begin

		// NOR
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100111)) begin

		// SLT
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b101010)) begin

		// SLTU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b101011)) begin

		// SLTI
		end else if(ifid_instr[31 : 26] == 6'b001010) begin

		// SLTIU
		end else if(ifid_instr[31 : 26] == 6'b001011) begin

		// SLL
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[25 : 21] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000000)) begin

		// SLLV
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000100)) begin

		// SRL
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[25 : 21] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000010)) begin

		// SRLV
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000110)) begin

		// SRA
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[25 : 21] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000011)) begin

		// SRAV
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000111)) begin

		// CLO
		end else if((ifid_instr[31 : 26] == 6'b011100) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100001)) begin

		// CLZ
		end else if((ifid_instr[31 : 26] == 6'b011100) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b100000)) begin

		// BEQ
		end else if(ifid_instr[31 : 26] == 6'b000100) begin

		// BEQL
		end else if(ifid_instr[31 : 26] == 6'b010100) begin

		// BGEZ
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b00001)) begin

		// BGTZ
		end else if((ifid_instr[31 : 26] == 6'b000111) &&
			(ifid_instr[20 : 16] == 5'b00000)) begin

		// BLEZ
		end else if((ifid_instr[31 : 26] == 6'b000110) &&
			(ifid_instr[20 : 16] == 5'b00000)) begin

		// BLTZ
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b00000)) begin

		// BNE
		end else if(ifid_instr[31 : 26] == 6'b000101) begin

		// TEQ
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b110100)) begin

		// TEQI
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b01100)) begin

		// TGE
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b110000)) begin

		// TGEI
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b01000)) begin

		// TGEU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b110001)) begin

		// TGEIU
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b01001)) begin

		// TLT
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b110010)) begin

		// TLTI
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b01010)) begin

		// TLTU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b110011)) begin

		// TLTIU
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b01011)) begin

		// TNE
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b110110)) begin

		// TNEI
		end else if((ifid_instr[31 : 26] == 6'b000001) &&
			(ifid_instr[20 : 16] == 5'b01110)) begin

		// J
		end else if(ifid_instr[31 : 26] == 6'b000010) begin

		// JAL
		end else if(ifid_instr[31 : 26] == 6'b000011) begin

		// JR
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[20 : 11] == 10'b0000000000) &&
			(ifid_instr[5 : 0] == 6'b001000)) begin

		// MOVN
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b001011)) begin

		// MOVZ
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b001010)) begin

		// LUI
		end else if((ifid_instr[31 : 26] == 6'b001111) &&
			(ifid_instr[25 : 21] == 5'b00000)) begin

		// MUL
		end else if((ifid_instr[31 : 26] == 6'b011100) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b000010)) begin

		// MULT
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[15 : 6] == 10'b0000000000) &&
			(ifid_instr[5 : 0] == 6'b011000)) begin

		// MULTU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[15 : 6] == 10'b0000000000) &&
			(ifid_instr[5 : 0] == 6'b011001)) begin

		// DIV
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[15 : 6] == 10'b0000000000) &&
			(ifid_instr[5 : 0] == 6'b011010)) begin

		// DIVU
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[15 : 6] == 10'b0000000000) &&
			(ifid_instr[5 : 0] == 6'b011011)) begin

		// MFHI
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[25 : 16] == 10'b0000000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b010000)) begin

		// MTHI
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[20 : 6] == 15'b000000000000000) &&
			(ifid_instr[5 : 0] == 6'b010001)) begin

		// MFLO
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[25 : 16] == 10'b0000000000) &&
			(ifid_instr[10 : 6] == 5'b00000) &&
			(ifid_instr[5 : 0] == 6'b010010)) begin

		// MTLO
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[20 : 6] == 15'b000000000000000) &&
			(ifid_instr[5 : 0] == 6'b010011)) begin

		// LB
		end else if(ifid_instr[31 : 26] == 6'b100000) begin

		// LBU
		end else if(ifid_instr[31 : 26] == 6'b100100) begin

		// LH
		end else if(ifid_instr[31 : 26] == 6'b100001) begin

		// LHU
		end else if(ifid_instr[31 : 26] == 6'b100101) begin

		// LW
		end else if(ifid_instr[31 : 26] == 6'b100011) begin

		// SB
		end else if(ifid_instr[31 : 26] == 6'b101000) begin

		// SH
		end else if(ifid_instr[31 : 26] == 6'b101001) begin

		// SW
		end else if(ifid_instr[31 : 26] == 6'b101011) begin

		// LWL
		end else if(ifid_instr[31 : 26] == 6'b100010) begin

		// LWR
		end else if(ifid_instr[31 : 26] == 6'b100110) begin

		// SWL
		end else if(ifid_instr[31 : 26] == 6'b101010) begin

		// SWR
		end else if(ifid_instr[31 : 26] == 6'b101110) begin

		// MFC0
		end else if((ifid_instr[31 : 26] == 6'b010000) &&
			(ifid_instr[25 : 21] == 5'b00000) &&
			(ifid_instr[10 : 3] == 8'b00000000)) begin

		// MTC0
		end else if((ifid_instr[31 : 26] == 6'b010000) &&
			(ifid_instr[25 : 21] == 5'b00100) &&
			(ifid_instr[10 : 3] == 8'b00000000)) begin

		// SYSCALL
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[5 : 0] == 6'b001100)) begin

		// ERET
		end else if((ifid_instr[31 : 26] == 6'b010000) &&
			(ifid_instr[25 : 6] == 20'b10000000000000000000) &&
			(ifid_instr[5 : 0] == 6'b011000)) begin

		// NOP
		end else if((ifid_instr[31 : 26] == 6'b000000) &&
			(ifid_instr[25 : 6] == 20'b00000000000000000000) &&
			(ifid_instr[5 : 0] == 6'b000000)) begin

		// invalid instruction
		end else begin

		end
	end
    
endmodule

