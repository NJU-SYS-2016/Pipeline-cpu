`timescale 1ns / 1ps

module cache_top_test();
    //from CPU 
	reg clk;
	reg rst;
	reg instr_req;
	reg data_r_req;
	reg data_w_req;
	reg [3:0] byte_w_en;
	reg [31:0] instr_addr;
	reg [31:0] data_addr;
	reg [31:0] data_in;

	//from RAM
	reg ddr_response; 	 //write back ready or load data ready
	reg [255:0] line_in;  //load data
	
	//TO CPU
	//output instr_response,
	//output data_response,
	wire mem_stall;
	wire [31:0] data_out;
	wire [31:0] instr_out;

	//TO RAM
	wire ram_en_out;
	wire ram_write_out;
	//output [19:0] tag_out,
	wire [31:0] ram_addr;
	wire [255:0] line_out;
	
	cache_top test6(
	   .clk(clk),
	   .rst(rst),
	   .instr_req(instr_req),
	   .data_r_req(data_r_req),
	   .data_w_req(data_w_req),
	   .byte_w_en(byte_w_en),
	   .instr_addr(instr_addr),
	   .data_addr(data_addr),
	   .data_in(data_in),
	   .ddr_response(ddr_response),
	   .line_in(line_in),
	   
	   .mem_stall(mem_stall),
	   .data_out(data_out),
	   .instr_out(instr_out),
	   .ram_en_out(ram_en_out),
	   .ram_write_out(ram_write_out),
	   .ram_addr(ram_addr),
	   .line_out(line_out));
	   
	 initial begin
	       clk = 1;
	       rst = 0;
	       instr_req = 0;
	       data_r_req = 0;
	       data_w_req = 1;
	       byte_w_en = 4'b11111;
	       instr_addr = 32'h0100_0000;
	       data_addr = 32'h0100_0000;
	       data_in = 32'hffff_ffff;
	       ddr_response = 1'b0;
	       line_in = 255'h11111111_22222222_33333333_44444444_55555555_66666666_77777777_88888888;
	       #20;
	       
	       ddr_response = 1'b1;
	       #40;
	       
	       data_r_req = 1;
	       data_w_req = 0;
	       ddr_response = 1'b0;
	       #20;
	       
	       instr_req = 1;
	       data_r_req = 0;
	       #60;
	       
	       instr_req = 0;
	       data_r_req = 1;
	       data_addr = 32'h0100_0004;
	       #20;
	       
	       data_r_req = 1;
	       instr_req = 1;
	       #24;
	       
	   end
	   
	   always begin
	   #10 clk = ~clk;
	   end

endmodule
