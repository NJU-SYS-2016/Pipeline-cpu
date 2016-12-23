/*
alu_lf 接alu部件的lf
alu_of 接alu部件的of
alu_zf 接alu部件的zf
trap 接idex流水段寄存器输出idex_trap
overflow_detect 接idex流水段寄存器输出idex_overflow_detect
excepttype_in 接idex流水段寄存器输出idex_excepttype
condition 接idex流水段寄存器输出idex_condition

excepttype_out 接exmem流水段寄存器输入excepttype_in
 */


/*
Branch
== : 001
>= : 011
< : 110
!= : 010 
 */
`define 	Equal			3'b001
`define 	NotEqual		3'b010
`define		GreaterEqual	3'b011
`define 	Less			3'b110

module except_detect2(
		input 				alu_lf,
		input				alu_of,
		input 				alu_zf,
		input				trap,
		input				overflow_detect,
		input[31:0]			excepttype_in,
		input[2:0]			condition,

		output reg[31:0]	excepttype_out
	);
	always@(*) begin
		if(overflow_detect == 1'b1 && alu_of == 1'b1) begin
			excepttype_out = excepttype_in | 32'h00000400;
		end
		if(trap == 1'b1) begin
			if( (condition == `Equal && alu_zf == 1'b1) ||
				(condition == `NotEqual && alu_zf == 1'b0) ||
				(condition == `GreaterEqual && alu_lf == 1'b0) ||
				(condition == `Less && alu_lf == 1'b1) ) begin
					excepttype_out = excepttype_in | 32'h00000800;
				end
		end
	end
endmodule