`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/12/08 10:07:27
// Design Name: 
// Module Name: cache_manage_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:
//   Cache 顶层模块，除了连�? cache 各部件外，还负责进行�?终的状�?�转�?
//   以及阻塞信号的生成�??
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module cache_manage_unit #(
	parameter RAM_WIDTH = 32,
	parameter RAM_ADDR_BITS = 13,
    parameter OFFSET_WIDTH = 3,                                         // Block address(offset) width
    parameter INDEX_WIDTH  = 6,                                         // Cache line(group) index width
    parameter ADDR_WIDTH   = 30,                                        // Total address width
    parameter DATA_WIDTH   = 32,                                        // Word size in bit
    // Local parameters
    parameter BLOCK_SIZE   = 1 << OFFSET_WIDTH,                         // Block size in word
    parameter CACHE_DEPTH  = 1 << INDEX_WIDTH,                          // Cache line(group) size
    parameter BLOCK_WIDTH  = DATA_WIDTH * BLOCK_SIZE,                   // A block width is the block size in bit
    parameter TAG_WIDTH    = ADDR_WIDTH - OFFSET_WIDTH - INDEX_WIDTH    // The remaining are tag width
) (
    // From CPU
    input                        clk,
    input                        rst,
    input                        ic_read_in,
    input                        dc_read_in,
    input                        dc_write_in,
    input [3 : 0]                dc_byte_w_en_in,
    input [ADDR_WIDTH - 1 : 0]   ic_addr,
    input [ADDR_WIDTH - 1 : 0]   dc_addr,
    input [DATA_WIDTH - 1 : 0]   data_from_reg,

    // From RAM
    input                        ram_ready,           // Inform control unit to go on
    input [BLOCK_WIDTH - 1 : 0]  block_from_ram,      // Total block loaded when cache misses

    // To CPU
    output                       mem_stall,
    output  [DATA_WIDTH - 1 : 0]  dc_data_out,
    output  [DATA_WIDTH - 1 : 0]  ic_data_out,

    // debug
    output  [2:0] status,
    // Cache 当前状�?�，表明 cache 是否*已经*发生缺失以及缺失类型，具体取值参�? status.vh.
    output  [2:0] counter,
    // 块内偏移指针/迭代器，用于载入块时逐字写入�?

    // To RAM
    output                       ram_en_out,          // Asserted when we need ram to work (load or writeback)
    output                       ram_write_out,       // RAM write enable
    output [ADDR_WIDTH - 1  : 0] ram_addr_out,
    output [BLOCK_WIDTH - 1 : 0] dc_data_wb           // Write back block, _wb for `write back'
);
    assign status = 0;
    assign counter = 0;
    
	(* ram_style="distributed" *)
	reg [RAM_WIDTH-1:0] regs [(2**RAM_ADDR_BITS)-1:0];

	initial begin
		$readmemh("/tmp/ram.txt",regs);
	end
	
	assign ram_en_out = 0;
	assign ram_write_out = 0;
	assign ram_addr_out = 0;
	assign dc_data_wb = 0;
	assign mem_stall = 0;
	
	assign ic_data_out = regs[ ic_addr[RAM_ADDR_BITS-1:0] ];
	assign dc_data_out = regs[ dc_addr[RAM_ADDR_BITS-1:0] ]
	
    always @ (posedge clk)
    begin
                if( rst )
                begin
					;
                end
                else
                begin
					if( dc_write_in )
					begin
						regs[ dc_addr[RAM_ADDR_BITS-1:0] ][7:0] 	<= (dc_byte_w_en_in[0]) ? data_from_reg[7:0] 	: regs[ dc_addr[RAM_ADDR_BITS-1:0] ][7:0];
						regs[ dc_addr[RAM_ADDR_BITS-1:0] ][15:8] 	<= (dc_byte_w_en_in[1]) ? data_from_reg[15:8] 	: regs[ dc_addr[RAM_ADDR_BITS-1:0] ][15:8];
						regs[ dc_addr[RAM_ADDR_BITS-1:0] ][23:16] 	<= (dc_byte_w_en_in[2]) ? data_from_reg[23:16]	: regs[ dc_addr[RAM_ADDR_BITS-1:0] ][23:16];
						regs[ dc_addr[RAM_ADDR_BITS-1:0] ][31:24] 	<= (dc_byte_w_en_in[3]) ? data_from_reg[31:24] 	: regs[ dc_addr[RAM_ADDR_BITS-1:0] ][31:24];
					end
                end
    end
	

endmodule


