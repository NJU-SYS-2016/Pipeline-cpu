`timescale 1ns / 1ps

module cache_word_memc(
   output [31:0] data_out,
   input  [6:0]     addr,
   input  [31:0]  data_in,
   input           write,
   input             clk,
   input             rst,
 //  input             load,
 //  input [31:0]	  re_data,
   input [3:0]	byte_w_en
  );

wire [7:0] byte_out [3:0];

memc #(8) byte0 (
    .data_out(byte_out[0]), 
    .addr(addr), 
    .data_in(data_in[7:0]), 
    .write(write & byte_w_en[0]), 
    .clk(clk), 
    .rst(rst));
    
memc #(8) byte1 (
    .data_out(byte_out[1]), 
    .addr(addr), 
    .data_in(data_in[15:8]), 
    .write(write & byte_w_en[1]), 
    .clk(clk), 
    .rst(rst));
    
memc #(8) byte2 (
    .data_out(byte_out[2]), 
    .addr(addr), 
    .data_in(data_in[23:16]), 
    .write(write & byte_w_en[2]), 
    .clk(clk), 
    .rst(rst));
    
memc #(8) byte3 (
    .data_out(byte_out[3]), 
    .addr(addr), 
    .data_in(data_in[31:24]), 
    .write(write & byte_w_en[3]), 
    .clk(clk), 
    .rst(rst));

assign data_out = {byte_out[3], byte_out[2], byte_out[1], byte_out[0]};

endmodule
