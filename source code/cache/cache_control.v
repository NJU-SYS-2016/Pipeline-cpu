`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/12/07 19:47:56
// Design Name: 
// Module Name: cache_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   负责生成 cache 的控制信号的组合逻辑，以�? cache 状�?�转移的次�?��?�辑（组合�?�辑�?
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "status.vh"

module cache_control(/* autoarg */
    //Inputs
    ic_read_in,
    dc_read_in, dc_write_in, 
    ic_hit_in, ic_valid_in, 
    dc_hit_in, dc_dirty_in, dc_valid_in, 
    status_in, counter_in, ic_word_sel_in, 
    dc_word_sel_in, dc_byte_w_en_in, 

    //Outputs
    ic_enable_reg, ic_cmp_reg, ic_write_reg, 
    ic_valid_reg, dc_enable_reg, dc_cmp_reg, 
    dc_write_reg, dc_valid_reg, ram_en_out, 
    ram_write_out, ram_addr_sel_reg, status_next_reg, 
    counter_next_reg, ic_word_sel_reg, dc_word_sel_reg, 
    ic_byte_w_en_reg, dc_byte_w_en_reg
);
input ic_read_in;
input dc_read_in;
input dc_write_in;
input ic_hit_in;
input ic_valid_in;
input dc_hit_in;
input dc_dirty_in;
input dc_valid_in;
input [2:0] status_in;
input [2:0] counter_in;
input [2:0] ic_word_sel_in;
input [2:0] dc_word_sel_in;
input [3:0] dc_byte_w_en_in;

output reg ic_enable_reg;
output reg ic_cmp_reg;
output reg ic_write_reg;
output reg ic_valid_reg;

output reg dc_enable_reg;
output reg dc_cmp_reg;
output reg dc_write_reg;
output reg dc_valid_reg;

output reg ram_en_out;
output reg ram_write_out;
output reg [1:0] ram_addr_sel_reg;
output reg [2:0] status_next_reg;
output reg [2:0] counter_next_reg;
output reg [2:0] ic_word_sel_reg;
output reg [2:0] dc_word_sel_reg;
output reg [3:0] ic_byte_w_en_reg;
output reg [3:0] dc_byte_w_en_reg;

// 下面�? always 块是�?个根据当前周�? cache 状�?�的 switch-case 语句
// 每个 case 下的行为模式基本相似，即�?
//   (1). 生成本周期的控制信号
//   (2). 决定下一周期状�??
// �?要注意的是，�? NORMAL 状�?�下，在 (1) �? (2) 之间，隐含着 cache_2way 的�?�辑�?
// 也就是说，在 (1) 控制信号生成后，�?要等�? cache_2way 的延迟，(2) �?依赖的信号才有效�?
// 此外，最终的状�?�转移时序电路，是在外部�? cache_manage_unit 完成的�??

always @(*) begin
    case(status_in)
        `STAT_IC_MISS:
        begin
            // I-cache 写入控制设定
            ic_enable_reg = 1;
            ic_cmp_reg = 0;
            ic_write_reg = 1;
            ic_byte_w_en_reg = 4'b1111;

            // I-cache 写入内容设定
            ic_valid_reg = 1;
            ic_word_sel_reg = counter_in;

            //for data coherrence
            dc_enable_reg = 1;
            dc_cmp_reg = 1;
            dc_write_reg = 0;
            dc_valid_reg = 1;

            dc_word_sel_reg = counter_in;//it is meaningful while loading from dc
            dc_byte_w_en_reg = 4'b0000;

            if(dc_hit_in && dc_valid_in)begin
                ram_en_out = 0;
            end
            else begin
                ram_en_out = 1;
            end

            // 设定�? ram 的访问行为，使用 ram_addr_ic, 只读
            ram_addr_sel_reg = 2'b00;  // 高位表示是否写回，低位表示是 ic 还是 dc
            ram_write_out = 0;

            if(counter_in ==  3'd4) begin
                ram_en_out = 0;
                status_next_reg = `STAT_NORMAL;
                counter_next_reg = 0;
            end
            else begin
                status_next_reg = `STAT_IC_MISS;
                counter_next_reg = counter_in + `N_WORDS;
            end
        end
        `STAT_DC_MISS:
        begin
            // 不使�? I-cache
            ic_enable_reg = 0;
            ic_cmp_reg = 0;
            ic_write_reg = 0;
            ic_valid_reg = 1;
            ic_word_sel_reg = counter_in;
            ic_byte_w_en_reg = 4'b0000;

            // �? D-cache
            dc_enable_reg = 1;
            dc_cmp_reg = 0;
            dc_write_reg = 1;
            dc_valid_reg = 1;
            dc_word_sel_reg = counter_in;
            dc_byte_w_en_reg = 4'b1111;

            // �? ram
            ram_addr_sel_reg = 2'b01;  // ram_addr_dc
            ram_en_out = 1;
            ram_write_out = 0;

            if(counter_in ==  3'd4) begin
                ram_en_out = 0;
                status_next_reg = `STAT_NORMAL;
                counter_next_reg = 0;
            end
            else begin
                status_next_reg = `STAT_DC_MISS;
                counter_next_reg = counter_in + `N_WORDS;
            end
        end
        `STAT_DC_MISS_D:
        begin
            // 不使�? I-cache
            ic_enable_reg = 0;
            ic_cmp_reg = 0;
            ic_write_reg = 0;
            ic_valid_reg = 1;
            ic_word_sel_reg = counter_in;
            ic_byte_w_en_reg = 4'b0000;

            // �? D-cache
            dc_enable_reg = 1;
            dc_cmp_reg = 0;
            dc_write_reg = 0;
            dc_valid_reg = 1;
            dc_word_sel_reg = counter_in;
            dc_byte_w_en_reg = 4'b0000;

            // �? ram
            ram_addr_sel_reg = 2'b11;  // ram_addr_dc_wb
            ram_en_out = 1;
            ram_write_out = 1;

            if(counter_in == `COUNT_FINISH) begin
                status_next_reg = `STAT_DC_MISS;
                counter_next_reg = 3'd0;  // Restart counter for D-cache loading
            end
            else begin
                status_next_reg = `STAT_DC_MISS_D;
                counter_next_reg = counter_in + `N_WORDS;
            end
        end
        `STAT_DOUBLE_MISS:
        begin
            // �? I-cache
            ic_enable_reg = 1;
            ic_cmp_reg = 0;
            ic_write_reg = 1;
            ic_byte_w_en_reg = 4'b1111;

            ic_valid_reg = 1;
            ic_word_sel_reg = counter_in;

            // �? D-cache
            dc_enable_reg = 1;
            dc_cmp_reg = 1;
            dc_write_reg = 0;
            dc_valid_reg = 1;
            dc_word_sel_reg = counter_in;
            dc_byte_w_en_reg = 4'b0000;

            // �? ram
            ram_addr_sel_reg = 2'b00;  // ram_addr_ic
            ram_write_out = 0;

            if (dc_hit_in && dc_valid_in) begin
                ram_en_out = 0;
            end
            else begin
                ram_en_out = 1;
            end
            if(counter_in ==  3'd4) begin
                ram_en_out = 0;
                status_next_reg = `STAT_DC_MISS;
                counter_next_reg = 0;  // Restart counter for D-cache loading
            end

            else begin
                status_next_reg = `STAT_DOUBLE_MISS;
                counter_next_reg = counter_in + `N_WORDS;
            end
        end
        `STAT_DOUBLE_MISS_D:
        begin
            // 不使�? I-cache
            ic_enable_reg = 0;
            ic_cmp_reg = 0;
            ic_write_reg = 0;
            ic_byte_w_en_reg = 4'b0000;
            ic_valid_reg = 1;
            ic_word_sel_reg = counter_in;

            // �? D-cache
            dc_enable_reg = 1;
            dc_cmp_reg = 0;
            dc_write_reg = 0;
            dc_byte_w_en_reg = 4'b0000;
            dc_valid_reg = 1;
            dc_word_sel_reg = counter_in;

            // �? ram
            ram_addr_sel_reg = 2'b11;  // ram_addr_dc_wb
            ram_en_out = 1;
            ram_write_out = 1;

            if(counter_in == `COUNT_FINISH) begin
                status_next_reg = `STAT_DOUBLE_MISS;
                counter_next_reg = 0;  // Restart counter for I-cache loading
            end
            else begin
                status_next_reg = `STAT_DOUBLE_MISS_D;
                counter_next_reg = counter_in + `N_WORDS;
            end
        end
        default: /*normal*/
        begin
            // Normal 状�?�下生成�?常规的控制信号�??

            ic_enable_reg = ic_read_in;
            ic_cmp_reg = 1;
            ic_word_sel_reg = ic_word_sel_in;
            ic_write_reg = 0;                          // I-cache 不会�? CPU 写�??
            ic_byte_w_en_reg = 4'b0000;

            dc_enable_reg = dc_read_in | dc_write_in;  // D-cache 的使能要根据具体的请求来设定�?
            dc_cmp_reg = 1;
            dc_word_sel_reg = dc_word_sel_in;
            dc_write_reg = dc_write_in;
            dc_byte_w_en_reg = dc_byte_w_en_in;

            // 当前并不�?要对 ram 进行操作
            ram_addr_sel_reg = 2'b00;
            ram_en_out = 0;
            ram_write_out = 0;

            /* cache_2way 响应 */

            ic_valid_reg = 1;
            dc_valid_reg = 1;

            counter_next_reg = 0;  // We can always reset counter in NORMAL status, as all other status using counter starting from 0.

            // 根据访问结果，决定下�?状�?�，先判�? D-cache miss, 再判�? I-cache miss, �?后判�? I-cache miss�?
            if(dc_enable_reg && !(dc_hit_in && dc_valid_in)) begin //dc miss
                if(ic_enable_reg && !(ic_hit_in && ic_valid_in)) begin //dc miss & ic miss
                    if(dc_dirty_in) begin //dc miss & ic miss & dc dirty
                        status_next_reg = `STAT_DOUBLE_MISS_D;
                    end
                    else begin //dc miss & ic miss & dc not dirty
                        status_next_reg = `STAT_DOUBLE_MISS;
                    end
                end
                else begin
                    if(dc_dirty_in) begin //dc miss & ic hit & dc dirty
                        status_next_reg = `STAT_DC_MISS_D;
                    end
                    else begin //dc miss & ic hit & dc not dirty
                        status_next_reg = `STAT_DC_MISS;
                    end
                end
            end
            else begin //dc hit & ic miss
                if(ic_enable_reg && !(ic_hit_in && ic_valid_in)) begin
                    status_next_reg = `STAT_IC_MISS;
                end
                else begin //dc hit & ic hit
                    status_next_reg = `STAT_NORMAL;
                end
            end
        end
    endcase 
end

endmodule
