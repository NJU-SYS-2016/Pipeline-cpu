/*
 syscall_i �������������idex_syscall
 eret �������������idex_eret
 invalid_inst_i �������������invalid_inst
 excepttype_o ��idex��ˮ�μĴ�����idex_excepttype_in
 */

module except_detect1(
		input 				syscall_i,
		input				eret,
		input 				invalid_inst_i,
		output reg[31:0]	excepttype_o
	);
	always@(*) begin
	   excepttype_o = 32'h00000000;
		if(syscall_i == 1'b1) begin
			excepttype_o = excepttype_o | 32'h00000100;
		end
		if(eret == 1'b1) begin
			excepttype_o = excepttype_o | 32'h00001000;
		end
		if(invalid_inst_i == 1'b1) begin
			excepttype_o = excepttype_o | 32'h00000200;
		end
	end
endmodule