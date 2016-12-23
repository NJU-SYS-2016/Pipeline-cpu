`define		pc_j_jal			0  //不需要，放在 pc_control_hazard与branch做相同处�?
//`define		pc_jr				1  
`define		pc_except			1
`define 	pc_eret				2
`define		pc_control_hazard 	3
`define		pc_append_4			4
`define 	except_new_pc		32'h10

module control_unit(
	input			reset,
	input			id_jmp,
	input 			mem_jr,       
	input			mem_branch_state,
	input			mem_stall,
	input[31:0]		mem_excepttype,
	input			idex_mem_r,
	input[4:0]		ifid_rs_addr,
	input[4:0]		ifid_real_rt_addr,
	input[4:0]		idex_real_rd_addr,

	output			reg cu_pc_stall,
	output 		    reg cu_ifid_stall,
	output			reg cu_idex_stall,
	output			reg cu_exmem_stall,
	output			reg cu_memwb_stall,
	output			reg cu_ifid_flush,
	output			reg cu_idex_flush,
	output			reg cu_exmem_flush,
	output reg [2:0]		cu_pc_src,
	output reg [31:0]	cu_vector
	);
	always@(*) begin
		cu_pc_stall		=		1'b0;
		cu_ifid_stall		=		1'b0;
		cu_idex_stall		=		1'b0;
		cu_exmem_stall	=		1'b0;
		cu_memwb_stall	=		1'b0;
		cu_ifid_flush		=		1'b0;
		cu_idex_flush		=		1'b0;
		cu_exmem_flush		=		1'b0;
		cu_pc_src 			= 		`pc_append_4; 
		cu_vector			=		32'h0;

		if(reset == 1'b1) begin
			cu_ifid_flush 	= 	1'b1; 
			cu_idex_flush	=	1'b1;
			cu_exmem_flush 	= 	1'b1;
		end
		else begin
			//中断异常处理
			if(mem_stall == 1'b1) begin
				cu_pc_stall		=		1'b1;
				cu_ifid_stall		=		1'b1;
				cu_idex_stall		=		1'b1;
				cu_exmem_stall	=		1'b1;
				cu_memwb_stall	=		1'b1;
			end
			else if(mem_excepttype != 32'h0) begin
				cu_ifid_flush		=		1'b1;
				cu_idex_flush		=		1'b1;
				cu_exmem_flush		=		1'b1;
				cu_pc_src			=		`pc_except;
				case(mem_excepttype)
					32'h1:/*interrupt0*/cu_vector = `except_new_pc;
					32'h2:/*interrupt1*/cu_vector = `except_new_pc;
					32'h3:/*interrupt2*/cu_vector = `except_new_pc;
					32'h4:/*interrupt3*/cu_vector = `except_new_pc;
					32'h5:/*interrupt4*/cu_vector = `except_new_pc;
					32'h6:/*interrupt5*/cu_vector = `except_new_pc;
					32'h7:/*interrupt6*/cu_vector = `except_new_pc;
					32'h8:/*interrupt7*/cu_vector = `except_new_pc;
					32'h9:/*syscall*/cu_vector = `except_new_pc;
					32'ha:/*ri无效指令*/cu_vector = `except_new_pc;
					32'hb:/*ov溢出异常*/cu_vector = `except_new_pc;
					32'hc:/*tr自陷异常*/cu_vector = `except_new_pc;
					32'hd:/*eret*/begin
						cu_pc_src	=	`pc_eret;
					end
				endcase
			end
			else begin
				//分支处理，控制异�?
				if(mem_branch_state == 1'b1) begin
					cu_pc_src 		= 	`pc_control_hazard;
					cu_ifid_flush 	=	1'b1;
					cu_idex_flush	=	1'b1;
				end
				else if(id_jmp == 1'b1) begin
					cu_pc_src = `pc_j_jal;
				end
				else if(mem_jr == 1'b1) begin
					cu_pc_src = `pc_control_hazard;
					cu_ifid_flush 	=	1'b1;
					cu_idex_flush	=	1'b1;
				end
				else if( idex_mem_r == 1'b1 && (ifid_rs_addr == idex_real_rd_addr || ifid_real_rt_addr == idex_real_rd_addr) ) begin
					//load-use 冒险处理
					cu_pc_stall = 1'b1;
					cu_ifid_stall = 1'b1;
					cu_idex_flush = 1'b1;
				end
			
			end
		end
	end

endmodule