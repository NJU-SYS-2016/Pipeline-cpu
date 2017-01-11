`timescale 1ns / 1ps

`include "status.vh"

module cache_top (

	//from CPU 
	input clk,
	input rst,
	input instr_req,
	input data_r_req,
	input data_w_req,
	input [3:0] byte_w_en,
	input [31:0] instr_addr,
	input [31:0] data_addr,
	input [31:0] data_in,

	//from RAM
	input ddr_response, 	 //write back ready or load data ready
	input [255:0] line_in,   //load data
	
	//TO CPU
	//output instr_response,
	//output data_response,
	output mem_stall,
	output [31:0] data_out,
	output [31:0] instr_out,

	//TO RAM
	output ram_en_out,
	output ram_write_out,
	//output [19:0] tag_out,
	output [31:0] ram_addr,
	output [255:0] line_out
	);

	wire [1:0] enable;
	wire [1:0] write;
	wire [1:0] compare;
	wire [1:0] load;

	wire [1:0] hit;
	wire [1:0] dirty;
	wire [1:0] valid;

	wire [19:0] i_tag_out, d_tag_out;    //use for write back
	wire [255:0] i_line_out, d_line_out; //write back
	wire [255:0] i_line_in;

	wire [31:0] i_out;
	wire [31:0] d_addr;
	wire d_cache_r_sel;

	wire [3:0] i_byte_w_en_out;
    wire [3:0] d_byte_w_en_out;
	wire [2:0] next_status;
	
	reg [2:0] status;
	reg write_load;

	initial begin
		status = `NORMAL;
		write_load = 0;
		//next_status = `NORMAL;
	end

	//wire write_back;
//	wire [6:0] index;

	assign d_addr 	 = d_cache_r_sel ? data_addr: instr_addr;
	assign i_line_in = (hit[1] & ~d_cache_r_sel) ? d_line_out:line_in;

	cache_control control(
		//.ddr_response(ddr_response),
		.instr_req(instr_req),
		.data_r_req(data_r_req),
		.data_w_req(data_w_req),
		.hit(hit),
		.dirty(dirty),
		.valid(valid),
		.byte_w_en_in(byte_w_en),
		.status(status),

		.enable(enable),
		.write(write),
		.compare(compare),
		.i_byte_w_en_out(i_byte_w_en_out),
		.d_byte_w_en_out(d_byte_w_en_out),
		.load(load),
		.ram_en_out(ram_en_out),
		.ram_write_out(ram_write_out),				//write or read RAM(load[1:0] == 2'b00 && ram_write_out == 1)
		.d_cache_r_sel(d_cache_r_sel),
		.next_status(next_status)
	//	.instr_response(instr_response),
	//	.data_response(data_r_response)
		);

	two_ways_cache i_cache(
		.clk(clk),
		.rst(rst),
		.enable(enable[0]),
		.write(write[0]),
		.compare(compare[0]),
		//.load(load[0]),
		.addr(instr_addr),
		.data_in(0),
		.line_in(i_line_in),//need select 
		.byte_w_en(i_byte_w_en_out),

		.hit(hit[0]),
		.dirty(dirty[0]),
		.valid(valid[0]),
		.tag_out(i_tag_out),
		.data_out(i_out), //need select
		.line_out(i_line_out)); //not use

	two_ways_cache d_cache(
		.clk(clk),
		.rst(rst),
		.enable(enable[1]),
		.write(write[1]),
		.compare(compare[1]),
		//.load(load[1]),
		.addr(d_addr),//need select
		.data_in(data_in),
		.line_in(line_in),
		.byte_w_en(d_byte_w_en_out),

		.hit(hit[1]),
		.dirty(dirty[1]),
		.valid(valid[1]),
		.tag_out(d_tag_out),
		.data_out(data_out),		//d cache data out
		.line_out(d_line_out));

	assign  instr_out 		= i_out;
	assign  line_out   		= d_line_out;			//only d cache need write back

	assign  ram_addr		= ram_write_out ? ({d_tag_out, data_addr[11:5], 5'b0}) : ((load[1] & ~load[0])? data_addr : ({i_tag_out, instr_addr[11:5], 5'b0}));

	// assign  instr_response  = d_cache_r_sel ? hit[1] : hit[0];
	// assign  data_response 	= hit[1];

	always @(negedge clk) begin
		if (rst) begin
			status <= `NORMAL;
			write_load <= 0;
		//	next_status <= `NORMAL;
		end
		else begin
		    if(status == `NORMAL) begin
		          status <= next_status;
		          write_load <= 0;
		    end
		    else begin
		        if(data_w_req) begin
		          write_load <= 1;
		        end
		        //hit from D cache or ddr response
		        if(ddr_response || (hit[1] & ~d_cache_r_sel)) begin
                   status <= next_status;
                end
		    end	
		end
	end

	assign  mem_stall = ( status != `NORMAL ) || (next_status != `NORMAL) || write_load;

endmodule
