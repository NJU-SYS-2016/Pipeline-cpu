`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/12/06 16:57:22
// Design Name: 
// Module Name: cache_oneline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//   2 路组相联 cache
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// use victimway to mux the data, valid, and dirty bits from the two
// cache modules
//
//////////////////////////////////////////////////////////////////////////////////


module cache_2ways(/*autoarg*/
    //Inputs
    clk, rst, enable, cmp, write, byte_w_en, 
    valid_in, tag_in, index, word_sel, data_in, 
    data_block_in, 

    //Outputs
    hit, dirty, valid_out, tag_out, data_out, 
    data_wb
);

parameter OFFSET_WIDTH = 3;
parameter BLOCK_SIZE = 1<<OFFSET_WIDTH;
parameter INDEX_WIDTH = 6;
parameter CACHE_DEPTH = 1<<INDEX_WIDTH;
parameter TAG_WIDTH = 30 - OFFSET_WIDTH - INDEX_WIDTH;

// system:
input clk;
input rst;

// control:
input enable;
input cmp;
input write;
input [3:0] byte_w_en;

// data and cache match related
input valid_in;
input [TAG_WIDTH-1:0] tag_in;
input [INDEX_WIDTH-1:0] index;
input [OFFSET_WIDTH-1:0] word_sel;
input [31:0] data_in;
input [(32*(2**OFFSET_WIDTH)-1) : 0] data_block_in;

output hit;
output dirty;

output valid_out;
output [TAG_WIDTH-1:0] tag_out;
output [31:0] data_out;
output [(32*(2**OFFSET_WIDTH)-1) : 0] data_wb;

// ff == flip flop
reg victimway_ff;
wire victimway;


always @ (posedge clk) begin
    victimway_ff <= victimway;
end

wire enable_to_line_0;
wire write_to_line_0;
wire hit_from_line_0;
wire dirty_from_line_0;
wire valid_from_line_0;
wire [TAG_WIDTH-1:0] tag_from_line_0;
wire [31:0] data_word_from_line_0;
wire [(32*(2**OFFSET_WIDTH)-1) : 0] data_block_from_line_0;
wire [(32*(2**OFFSET_WIDTH)-1) : 0] data_block_to_line_0 = data_block_in;

wire enable_to_line_1;
wire write_to_line_1;
wire hit_from_line_1;
wire dirty_from_line_1;
wire valid_from_line_1;
wire [TAG_WIDTH-1:0] tag_from_line_1;
wire [31:0] data_word_from_line_1;
wire [(32*(2**OFFSET_WIDTH)-1) : 0] data_block_from_line_1;
wire [(32*(2**OFFSET_WIDTH)-1) : 0] data_block_to_line_1 = data_block_in;

//input to both oneline cache :
//index, word_sel, cmp, tag_in, data_in, valid_in, byte_w_en, clk, rst

victimway_sel vs0(/*autoinst*/
    .rst         ( rst               ),
    .enable      ( enable            ),
    .cmp         ( cmp               ),
    .line0_valid ( valid_from_line_0 ),
    .line1_valid ( valid_from_line_1 ),
    .line0_dirty ( dirty_from_line_0 ),
    .line1_dirty ( dirty_from_line_1 ),
    .prev        ( victimway_ff      ),
    .v           ( victimway         )
);

cache_oneline #(OFFSET_WIDTH,BLOCK_SIZE,INDEX_WIDTH,CACHE_DEPTH,TAG_WIDTH) c0(/*autoinst*/
    .clk                        (clk                                        ),
    .rst                        (rst                                        ),
    .enable                     (enable_to_line_0                           ),
    .cmp                        (cmp                                        ),
    .write                      (write_to_line_0                            ),
    .byte_w_en                  (byte_w_en                                  ),

    .valid_in                   (valid_in                                   ),
    .tag_in                     (tag_in                                     ),
    .index                      (index                                      ), 
    .word_sel                   (word_sel                                   ), 
    .data_in                    (data_in                                    ),
    .data_block_in              (data_block_to_line_0                       ),

    .hit                        (hit_from_line_0                            ),
    .dirty                      (dirty_from_line_0                          ),
    .valid_out                  (valid_from_line_0                          ),
    .tag_out                    (tag_from_line_0                            ),
    .data_out                   (data_word_from_line_0                      ),
    .data_wb                    (data_block_from_line_0                     )
);

cache_oneline #(OFFSET_WIDTH,BLOCK_SIZE,INDEX_WIDTH,CACHE_DEPTH,TAG_WIDTH) c1(/*autoinst*/
    .clk                        (clk                                        ),
    .rst                        (rst                                        ),
    .enable                     (enable_to_line_1                           ),
    .cmp                        (cmp                                        ),
    .write                      (write_to_line_1                            ),
    .byte_w_en                  (byte_w_en                                  ),

    .valid_in                   (valid_in                                   ),
    .tag_in                     (tag_in                                     ),
    .index                      (index                                      ), 
    .word_sel                   (word_sel                                   ), 
    .data_in                    (data_in                                    ),
    .data_block_in              (data_block_to_line_1                       ),

    .hit                        (hit_from_line_1                            ),
    .dirty                      (dirty_from_line_1                          ),
    .valid_out                  (valid_from_line_1                          ),
    .tag_out                    (tag_from_line_1                            ),
    .data_out                   (data_word_from_line_1                      ),
    .data_wb                    (data_block_from_line_1                     )
);


// 如果 cmp 有效，那么两�? cache 的有效�?�与 enable 保持�?致，
// 即同时有效或者无效，适用于正常访问时对两路进行标签验证的场景�?
// cmp 无效时，�?般是载入块，这时候需要一路有效，用以下的 victimway 的写法保证路的使用是互斥的�??
// zyy: if cmp is inactive, victimway is equal to victimway_ff 
// the signal 'go' in victimway_sel depend on cmp;
// In fact, it is redundancy...Victimway_ff should be removed.
assign enable_to_line_0 = cmp ? enable : ~victimway_ff;
assign enable_to_line_1 = cmp ? enable : victimway_ff;

// 在写请求下，如果 cmp 有效，即正常访问，则判断对应块是否存在来决定是否可写
// �? cmp 无效时，则由 victimway 来决定那个块可写，并保证写使能是独热的�??
assign write_to_line_0 = write & (cmp ? (valid_from_line_0 & hit_from_line_0 & enable) : ~victimway_ff);
assign write_to_line_1 = write & (cmp ? (valid_from_line_1 & hit_from_line_1 & enable) : victimway_ff);

// 对外部，只要有一�? hit �? cache hit.
// valid �? hit 的�?�辑相似�?
assign hit = ((valid_from_line_1 & hit_from_line_1) | (valid_from_line_0 & hit_from_line_0)) & enable;
assign valid_out = (valid_from_line_0 | valid_from_line_1) & enable;

// dirty 用于通知外部�?要进行写回操作�?�victim_sel 优先选择不脏的路进行替换�?
// 只有在所有的路都脏的情况下才进行�?要�?�知外界进行写回操作�?
assign dirty = dirty_from_line_0 & dirty_from_line_1;
//assign data_out = cmp ? ((hit0 & valid0) ? data0 : data1) : (victimway_ff ? data1 : data0);

// 输出数据的多路�?�择。cache 中有大量的多路�?�择，用于决定块、组、路�?
// 决定使用哪一路，是在块与组都选择完毕后才确定的�??
assign data_out = (hit_from_line_0 & valid_from_line_0) ? data_word_from_line_0 : data_word_from_line_1;

// 写回数据
// assign data_wb = cmp ? {(32*(2**OFFSET_WIDTH)){1'b0}}
//                     : (victimway_ff ? data_block_from_line_1 : data_block_from_line_0);
assign data_wb = cmp ? 
    ((hit_from_line_0 & valid_from_line_0) ? data_block_from_line_0 : data_block_from_line_1)
    : (victimway_ff ? data_block_from_line_1 : data_block_from_line_0);

//if !cmp, then tag_out is used for write back, and it should be the victimway's tag
assign tag_out = cmp ? {TAG_WIDTH{1'b0}}
                     : (victimway_ff ? tag_from_line_1 : tag_from_line_0);

endmodule
