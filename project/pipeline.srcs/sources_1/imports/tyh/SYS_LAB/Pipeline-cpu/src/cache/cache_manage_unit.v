`timescale 1ns / 1ps

`include "status.vh"

module cache_manage_unit(

	//from CPU 
	input 			clk,				//cache clock
	input 			rst,				//cache reset signal
	input 			ic_read_in,			//CPU instruction request
	input 			dc_read_in,			//CPU data read request
	input 			dc_write_in,		//CPU data write request
	input [3:0] 	dc_byte_w_en_in,	//write byte enable
	input [29:0]	ic_addr,			//instruction address
	input [29:0]	dc_addr,			//data address
	input [31:0]	data_from_reg,		//data write to cache

	//from RAM
	input			ram_ready,			//RAM response
	input [255:0]	block_from_ram,		//load data line

	//To CPU
	output 			mem_stall,			//CPU wait memery
	output [31:0]	dc_data_out,		//data read from D cache
	output [31:0]	ic_data_out,		//data read from I cache

	//debug 
	output reg [2:0] status,

	output reg [2:0] counter,

	//To ram
	output			ram_en_out,			//Asserted when we need ram to work (load or writeback)
	output			ram_write_out,		//RAM write enable
	output [29:0]	ram_addr_out,		//RAM write or read address(ram_en_out == 1)
	output [255:0]  dc_data_wb			//write back block
	);

	
	//wire instr_response;
	//wire data_response;

	wire [31:0] ram_addr;

	cache_top cache(
		.clk(clk),
		.rst(rst),
		.instr_req(ic_read_in),
		.data_r_req(dc_read_in),
		.data_w_req(dc_write_in),
		.byte_w_en(dc_byte_w_en_in),
		.instr_addr({ic_addr, 2'b0}),
		.data_addr({dc_addr, 2'b0}),
		.data_in(data_from_reg),
		.ddr_response(ram_ready), 	 
		.line_in(block_from_ram), 

		//.instr_response(instr_response),
		//.data_response(data_response),
		.mem_stall(mem_stall),
		.data_out(dc_data_out),
		.instr_out(ic_data_out),
		.ram_en_out(ram_en_out),
		.ram_write_out(ram_write_out),
		.ram_addr(ram_addr),
		.line_out(dc_data_wb)
		);

	assign ram_addr_out = ram_addr[31:2];
endmodule
