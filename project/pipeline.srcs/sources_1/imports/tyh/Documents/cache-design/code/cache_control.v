`timescale 1ns / 1ps

`include "status.vh"

module cache_control (
//	input write_back_response,
//	input load_data_response,
//	input ddr_response,

	input instr_req,
	input data_r_req,
	input data_w_req,
	input [1:0] hit,
	input [1:0] dirty,
	input [1:0] valid,
	input [3:0] byte_w_en_in,

	input [2:0] status,

	output reg [1:0] enable,
	output reg [1:0] write,
	output reg [1:0] compare,
	output reg [3:0] i_byte_w_en_out ,
	output reg [3:0] d_byte_w_en_out ,

	output reg [1:0] load,
	output reg ram_en_out,
	output reg ram_write_out,      //cache write back or load request
	output reg d_cache_r_sel,
	//output reg [1:0] ram_addr_sel,

	//output reg instr_response, //instruction response to core
	//output reg data_response   //data response to core
	output reg [2:0] next_status
	
	);
	/*TODO: control logic module*/
	//reg [1:0] d_cache_status;	//D cache status(00:free 01:I cache read D cache 10:CPU read or write D cache)
	//reg ram_cache_line_status;  //somebody use the load line between ram and cache

	initial begin
		enable = 2'b00;
		write = 2'b00;
		compare = 2'b00;
		i_byte_w_en_out = 4'b0000;
		d_byte_w_en_out = 4'b0000;

		load = 2'b00;
		ram_en_out = 1'b0;
		ram_write_out = 1'b0;
		d_cache_r_sel = 1'b1;
		// instr_response = 1'b0;
		// data_response = 1'b0;
	//	ram_addr_sel = 2'b00;
		next_status = 0;
		//d_cache_status = 2'b00
		//ram_cache_line_status = 1'b0;
	end

	always @(*) begin
		case(status)
		 `IC_MISS:
		begin
			// I cache write enable
			enable[0] = 1'b1;
			compare[0] = 1'b0;
			write[0] = 1'b1;
			i_byte_w_en_out = 4'b1111;

			//find Data from D cache
			d_cache_r_sel = 1'b0;

			enable[1] = 1'b1;
			compare[1] = 1'b1;
			write[1] = 1'b0;
			d_byte_w_en_out = 4'b0000;

			load = 2'b01;  //load cache line from D cache or RAM
			//ram_addr_sel = 2'b00;//ram addr sel


			ram_en_out = 1'b1; //read RAM

			ram_write_out = 1'b0;
			next_status = `NORMAL; //I cache

		end
		`DC_MISS:
		begin
			//
			enable[0] = 1'b0;
			compare[0] = 1'b0;
			write[0] = 1'b0;
			i_byte_w_en_out = 4'b0000;

			d_cache_r_sel = 1'b1;

			enable[1] = 1'b1;
			compare[1] = 1'b0;
			write[1] = 1'b1;
			d_byte_w_en_out = 4'b1111;

			load = 2'b10;

			//ram_addr_sel = 2'b01;
			ram_en_out = 1'b1;
			ram_write_out = 1'b0;

			next_status = `NORMAL;
		end
		`DC_MISS_DIRTY:
		begin
			enable[0] = 1'b0;
			compare[0] = 1'b0;
			write[0] = 1'b0;
			i_byte_w_en_out = 4'b0000;

			d_cache_r_sel = 1'b1;

			enable[1] = 1'b1;
			compare[1] = 1'b0;
			write[1] =	1'b0;
			d_byte_w_en_out = 4'b0000;

		//	ram_addr_sel = 2'b11;
			load = 2'b00;
			ram_en_out = 1'b1;
			ram_write_out = 1'b1;

			next_status = `DC_MISS;
		end

		`DOUBLE_MISS:
		begin
			enable[0] = 1'b1;
			compare[0] = 1'b0;
			write[0] = 1'b1;
			i_byte_w_en_out = 4'b1111;

			d_cache_r_sel = 1'b0;

			enable[1] = 1'b1;
			compare[1] = 1'b1;
			write[1] = 1'b0;
			d_byte_w_en_out = 4'b0000;

			load = 2'b01;  //load cache line from D cache or RAM
			ram_en_out = 1'b1; //
			ram_write_out = 1'b0;

			next_status = `DC_MISS;

		end
		`DOUBLE_MISS_DC_DIRTY:
		begin
			enable[0] = 1'b0;
			compare[0] = 1'b0;
			write[0] = 1'b0;
			i_byte_w_en_out = 4'b0000;

			d_cache_r_sel = 1'b1;

			enable[1] = 1'b1;
			compare[1] = 1'b0;
			write[1] = 1'b0;
			d_byte_w_en_out = 4'b0000;

			load = 2'b00;
			ram_en_out = 1'b1;
			ram_write_out = 1'b1;

			next_status = `DOUBLE_MISS;
		end
		default:
		begin
			enable[0] = instr_req;
			compare[0] = 1'b1;
			write[0] = 1'b0;
			i_byte_w_en_out = 4'b0000;

			enable[1] = data_w_req | data_r_req;
			compare[1] = 1'b1;
			write[1] = data_w_req;
			d_byte_w_en_out = byte_w_en_in;

			load = 2'b00;
			ram_en_out = 1'b0;
			ram_write_out = 1'b0;
			//ram_addr_sel = 2'b00;
			d_cache_r_sel = 1'b1;

			if(enable[1] && !hit[1]) begin
				if(enable[0] && !hit[0]) begin //D cache miss and I cache miss
					if(dirty[1]) begin
						next_status = `DOUBLE_MISS_DC_DIRTY; //D cache dirty
					end
					else begin
						next_status = `DOUBLE_MISS;
					end
				end
				else begin //D cache miss and I cache hit
					if(dirty[1]) begin
						next_status = `DC_MISS_DIRTY;
					end
					else begin
						next_status = `DC_MISS; //D cache miss and I cache hit
					end
				end
			end
			else begin
				if(enable[0] && !hit[0]) begin  //D cache hit amd  I cache miss
					next_status = `IC_MISS;
				end
				else begin
					next_status = `NORMAL; //D cache hit amd  I cache hit
				end
			end

		end
		endcase
	end
endmodule
