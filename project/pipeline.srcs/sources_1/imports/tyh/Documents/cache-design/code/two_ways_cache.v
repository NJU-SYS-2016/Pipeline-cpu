`timescale 1ns / 1ps

module two_ways_cache(
		input clk,
		input rst,
		input enable,
		input write,
		input compare,
		//input load,
		input [31:0] addr,
		input [31:0] data_in,
		input [255:0] line_in,
		input [3:0] byte_w_en,

		output hit,
		output dirty,
		output valid,
		output [19:0] tag_out,
		output [31:0] data_out,
		output [255:0] line_out
	);

	//input
	wire [19:0] tag_in;
	wire [6:0] index;
	wire [2:0] word;
	wire write0, write1;

	//output
	wire hit0, hit1;
	wire dirty0, dirty1;
	wire valid0, valid1;
	wire [19:0] tag_out0, tag_out1;
	wire [31:0] data_out0,data_out1;
	wire [255:0] line_out0, line_out1;

	wire victim;

	assign tag_in = addr[31:12];
	assign index  = addr[11:5];
	assign word   = addr[4:2] ;

	assign write0 = compare ? write : ~victim;
	assign write1 = compare ? write :  victim;

	direct_mapped_cache cache_way0 (
		.clk(clk), 
		.rst(rst), 
		.enable(enable), 
		.write(write0), 
		.compare(compare), 
		//.load(load), 
		.tag_in(tag_in), 
		.index(index), 
		.word(word), 
		.data_in(data_in), 
		.line_in(line_in), 
		.byte_w_en(byte_w_en),

		.hit(hit0),
		.dirty(dirty0),
		.valid(valid0),
		.tag_out(tag_out0),
		.data_out(data_out0),
		.line_out(line_out0));

	direct_mapped_cache cache_way1 (
		.clk(clk), 
		.rst(rst), 
		.enable(enable), 
		.write(write1), 
		.compare(compare), 
		//.load(load), 
		.tag_in(tag_in), 
		.index(index), 
		.word(word), 
		.data_in(data_in), 
		.line_in(line_in), 
		.byte_w_en(byte_w_en),

		.hit(hit1),
		.dirty(dirty1),
		.valid(valid1),
		.tag_out(tag_out1),
		.data_out(data_out1),
		.line_out(line_out1));

	victim_line_decide decide(
		.rst(rst),
		.enable(enable),
		.compare(compare),
		.dirty({dirty1, dirty0}),
		.valid({valid1, valid0}),

		.victim(victim)
		);

	assign hit      = hit0 | hit1 ;
	//assign dirty    = victim ? dirty1 : dirty0;
	//assign valid    = victim ? valid1 : valid0;
	assign dirty    = hit ? (hit1 ? dirty1:dirty0):(victim ? dirty1:dirty0);
	assign valid    = hit ? (hit1 ? valid1:valid0):(victim ? valid1:valid0);
	assign tag_out  = hit ? (hit1 ? tag_out1:tag_out0):(victim ? tag_out1 : tag_out0);
	//assign data_out = (hit & hit1) ? data_out1 : data_out0;
	assign data_out = hit ? (hit1 ? data_out1:data_out0):(victim ? data_out1 : data_out0);
	assign line_out = hit ? (hit1 ? line_out1:line_out0):(victim ? line_out1 : line_out0);
endmodule
