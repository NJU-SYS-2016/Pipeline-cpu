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
`include "status.vh"

module cache_manage_unit #(
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
    output [DATA_WIDTH - 1 : 0]  dc_data_out,
    output [DATA_WIDTH - 1 : 0]  ic_data_out,

    // debug
    output reg  [2:0] status,
    // Cache 当前状�?�，表明 cache 是否*已经*发生缺失以及缺失类型，具体取值参�? status.vh.
    output reg  [2:0] counter,
    // 块内偏移指针/迭代器，用于载入块时逐字写入�?

    // To RAM
    output                       ram_en_out,          // Asserted when we need ram to work (load or writeback)
    output                       ram_write_out,       // RAM write enable
    output [ADDR_WIDTH - 1  : 0] ram_addr_out,
    output [BLOCK_WIDTH - 1 : 0] dc_data_wb           // Write back block, _wb for `write back'
);

wire [2:0] status_next;  // �? cache control 生成的次态信号�??

wire [2:0] counter_next; // �? cache control 决定的下�?周期迭代器的值�??

reg write_after_load;    // 标记导致阻塞的是否是写操作，是的话，要多阻塞�?个周期完成写入�??

wire loading_ic = status ==`STAT_IC_MISS || status == `STAT_DOUBLE_MISS;  // for simple coherence

wire [3:0] byte_w_en_to_ic;
wire [3:0] byte_w_en_to_dc;

wire enable_to_ic, cmp_to_ic, write_to_ic, valid_to_ic;
wire enable_to_dc, cmp_to_dc, write_to_dc, valid_to_dc;

wire [OFFSET_WIDTH - 1 : 0] ic_word_sel;
wire [OFFSET_WIDTH - 1 : 0] dc_word_sel;

wire [DATA_WIDTH - 1 : 0] word_to_ic;
wire [DATA_WIDTH - 1 : 0] word_from_ic;
wire [DATA_WIDTH - 1 : 0] word_to_dc;
wire [DATA_WIDTH - 1 : 0] word_from_dc;

wire [BLOCK_WIDTH - 1 : 0] block_to_ic;
wire [BLOCK_WIDTH - 1 : 0] block_to_dc;
wire [BLOCK_WIDTH - 1 : 0] block_from_dc;

wire [OFFSET_WIDTH - 1 : 0] ic_offset;
wire [OFFSET_WIDTH - 1 : 0] dc_offset;

wire [INDEX_WIDTH - 1 : 0] index_to_ic;
wire [INDEX_WIDTH - 1 : 0] index_to_dc;

wire [TAG_WIDTH - 1 : 0] tag_to_ic;
wire [TAG_WIDTH - 1 : 0] tag_to_dc;
wire [TAG_WIDTH - 1 : 0] tag_from_ic;
wire [TAG_WIDTH - 1 : 0] tag_from_dc;

wire [ADDR_WIDTH - 1 : 0] ram_addr_ic;
wire [ADDR_WIDTH - 1 : 0] ram_addr_dc;
wire [ADDR_WIDTH - 1 : 0] ram_addr_dc_wb;

wire [1:0] ram_addr_sel;

// 提取 I-cache 访问请求的信�?
assign tag_to_ic   = ic_addr[ADDR_WIDTH - 1 -: TAG_WIDTH];
assign index_to_ic = ic_addr[OFFSET_WIDTH +: INDEX_WIDTH];
assign ic_offset   = ic_addr[OFFSET_WIDTH - 1 : 0];

// 提取 D-cache 访问请求的信�?
// when load block for instruction cache, if target block is in data_cache
// it should be loaded from data_cache.
assign tag_to_dc   = (~loading_ic) ? dc_addr[ADDR_WIDTH - 1 -: TAG_WIDTH] : tag_to_ic;
assign index_to_dc = (~loading_ic) ? dc_addr[OFFSET_WIDTH +: INDEX_WIDTH] : index_to_ic;
assign dc_offset   =  dc_addr[OFFSET_WIDTH - 1 : 0];


// 发�?�给 ram 的地�?来源:
//   00: ram_addr_ic
//   01: ram_addr_dc
//   1x: ram_addr_dc_wb
assign ram_addr_ic    = {tag_to_ic,   index_to_ic, counter};
assign ram_addr_dc    = {tag_to_dc,   index_to_dc, counter};
assign ram_addr_dc_wb = {tag_from_dc, index_to_dc ,counter};  // write back
assign ram_addr_out = ram_addr_sel[1] ? ram_addr_dc_wb
                                      : (ram_addr_sel[0] ? ram_addr_dc : ram_addr_ic);


// 虽然这些 wire 变量没有被复用，但是体现了语�?
assign dc_data_out = word_from_dc;
assign ic_data_out = word_from_ic;
assign dc_data_wb  = block_from_dc;
assign word_to_ic  = 0;  // I-cache 不需要来�? CPU 的写操作
assign word_to_dc  = data_from_reg;
assign block_to_ic = (loading_ic && hit_from_dc) ? block_from_dc : block_from_ram;
assign block_to_dc = block_from_ram;

wire hit_from_ic, valid_from_ic;
wire hit_from_dc, valid_from_dc, dirty_from_dc; // 5 outputs of i&d cache

wire [2:0] word_sel_to_ic;
wire [2:0] word_sel_to_dc;

// 控制单元，大部分控制信号在这里生成�??

cache_control cctrl (
    .ic_read_in     (ic_read_in         ),
    .dc_read_in     (dc_read_in         ),
    .dc_write_in    (dc_write_in        ),
    .ic_hit_in      (hit_from_ic        ),
    .ic_valid_in    (valid_from_ic      ),

    .dc_hit_in      (hit_from_dc        ),
    .dc_dirty_in    (dirty_from_dc      ),
    .dc_valid_in    (valid_from_dc      ),

    .status_in      (status             ),
    .counter_in     (counter            ),
    .ic_word_sel_in (ic_offset          ),
    .dc_word_sel_in (dc_offset          ),
    .dc_byte_w_en_in(dc_byte_w_en_in    ),


    .ic_enable_reg  (enable_to_ic       ),
    .ic_cmp_reg     (cmp_to_ic          ),
    .ic_write_reg   (write_to_ic        ),
    .ic_valid_reg   (valid_to_ic        ),

    .dc_enable_reg  (enable_to_dc       ),
    .dc_cmp_reg     (cmp_to_dc          ),
    .dc_write_reg   (write_to_dc        ),
    .dc_valid_reg   (valid_to_dc        ),

    .ram_en_out     (ram_en_out         ),
    .ram_write_out  (ram_write_out      ),

    .ram_addr_sel_reg   (ram_addr_sel           ),
    .status_next_reg    (status_next            ),
    .counter_next_reg   (counter_next           ),

    .ic_word_sel_reg    (word_sel_to_ic         ),
    .dc_word_sel_reg    (word_sel_to_dc         ),
    .ic_byte_w_en_reg   (byte_w_en_to_ic        ),
    .dc_byte_w_en_reg   (byte_w_en_to_dc        )
);



// Instruction Cache
cache_2ways #(OFFSET_WIDTH,BLOCK_SIZE,INDEX_WIDTH,CACHE_DEPTH,TAG_WIDTH) ic(
    .clk           ( clk             ),
    .rst           ( rst             ),
    .enable        ( enable_to_ic    ),
    .cmp           ( cmp_to_ic       ),
    .write         ( write_to_ic     ),
    .byte_w_en     ( byte_w_en_to_ic ),
    .valid_in      ( valid_to_ic     ),
    .tag_in        ( tag_to_ic       ),
    .index         ( index_to_ic     ),
    .word_sel      ( word_sel_to_ic  ),
    .data_in       ( word_to_ic      ),
    .data_block_in ( block_to_ic     ),
    .hit           ( hit_from_ic     ),
    .dirty         ( /* not used */  ),
    .valid_out     ( valid_from_ic   ),
    .tag_out       ( tag_from_ic     ),
    .data_out      ( word_from_ic    ),
    .data_wb       ( /* not used */  )
);

// Data Cache
cache_2ways #(OFFSET_WIDTH,BLOCK_SIZE,INDEX_WIDTH,CACHE_DEPTH,TAG_WIDTH) dc(
    .clk           ( clk             ),
    .rst           ( rst             ),
    .enable        ( enable_to_dc    ),
    .cmp           ( cmp_to_dc       ),
    .write         ( write_to_dc     ),
    .byte_w_en     ( byte_w_en_to_dc ),
    .valid_in      ( valid_to_dc     ),
    .tag_in        ( tag_to_dc       ),
    .index         ( index_to_dc     ),
    .word_sel      ( word_sel_to_dc  ),
    .data_in       ( word_to_dc      ),
    .data_block_in ( block_to_dc     ),
    .hit           ( hit_from_dc     ),
    .dirty         ( dirty_from_dc   ),
    .valid_out     ( valid_from_dc   ),
    .tag_out       ( tag_from_dc     ),
    .data_out      ( word_from_dc    ),
    .data_wb       ( block_from_dc   )
);

// 状�?�转移�?�辑
always @(posedge clk) begin
    if (rst) begin
        status <= `STAT_NORMAL;
        counter <= 0;
        write_after_load <= 0;
    end
    else begin
        if (status == `STAT_NORMAL) begin
            status <= status_next;
            counter <= counter_next;
            write_after_load <= 0;
        end
        else begin
            if (dc_write_in) begin
                write_after_load <= 1;
            end
            // loading_ic && hit_from_ic 在如下场景下有意义：
            // 如果 I-cache 缺失的数据在 D-cache 中已经存在并被载入，
            // 那么就不�?要等待存储器准备好，而尽早地结束阻塞状�?��??
            // 其他情况下，ram_ready 至少对于 counter 的更新是必要的�??
            if(ram_ready || (loading_ic && hit_from_dc)) begin
                status <= status_next;
                counter <= counter_next;
            end
        end
    end
end

assign mem_stall = (status      != `STAT_NORMAL) ||  // Cache 处于缺失处理过程�?
                   (status_next != `STAT_NORMAL) ||  // 本周期访�? cache 发生 miss
                   write_after_load ;                // 为写操作续一个周�?

endmodule
