`timescale 1ns / 1ps

module direct_mapped_cache (
		input clk,
		input rst,
		input enable,
		input write,
		input compare,
//		input load,
		input [19:0] tag_in,
		input [6:0] index,
		input [2:0] word,
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
	
	wire [31:0]      w0, w1, w2, w3, w4, w5, w6, w7;
	wire [31:0]      data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7;
	wire [3:0]       byte_w_en_r;
   assign            go = enable & ~rst;
   assign            match = (tag_in == tag_out);

   assign            wr_word0 = ~compare ? (write & go):(go & write & ~word[2] & ~word[1] & ~word[0] & match);
   assign            wr_word1 = ~compare ? (write & go):(go & write & ~word[2] & ~word[1] &  word[0] & match);
   assign            wr_word2 = ~compare ? (write & go):(go & write & ~word[2] &  word[1] & ~word[0] & match);
   assign            wr_word3 = ~compare ? (write & go):(go & write & ~word[2] &  word[1] &  word[0] & match);
   assign            wr_word4 = ~compare ? (write & go):(go & write &  word[2] & ~word[1] & ~word[0] & match);
   assign            wr_word5 = ~compare ? (write & go):(go & write &  word[2] & ~word[1] &  word[0] & match);
   assign            wr_word6 = ~compare ? (write & go):(go & write &  word[2] &  word[1] & ~word[0] & match);
   assign            wr_word7 = ~compare ? (write & go):(go & write &  word[2] &  word[1] &  word[0] & match);

   assign            wr_dirty = go & write & (match | ~compare);
   assign            wr_tag   = go & write & ~compare;
   assign            wr_valid = go & write & ~compare;
   assign            dirty_in = compare;  // a compare-and-write sets dirty; a cache-fill clears it


   assign           byte_w_en_r = (~compare & write) ? 4'b1111:byte_w_en;
   assign           data_in0    = ~compare ? line_in[31:0]:data_in;
   assign           data_in1    = ~compare ? line_in[63:32]:data_in;
   assign           data_in2    = ~compare ? line_in[95:64]:data_in;
   assign           data_in3    = ~compare ? line_in[127:96]:data_in;
   assign           data_in4    = ~compare ? line_in[159:128]:data_in;
   assign           data_in5    = ~compare ? line_in[191:160]:data_in;
   assign           data_in6    = ~compare ? line_in[223:192]:data_in;
   assign           data_in7    = ~compare ? line_in[255:224]:data_in;

   cache_word_memc mem_w0 ( //word0
        .data_out(w0), 
        .addr(index), 
        .data_in(data_in0),  
        .write(wr_word0), 
        .clk(clk), 
        .rst(rst), 
       // .load(load), 
       // .re_data(line_in[31:0]), 
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w1 ( //word1
        .data_out(w1),      
        .addr(index), 
        .data_in(data_in1),  
        .write(wr_word1), 
        .clk(clk), 
        .rst(rst), 
        //.load(load), 
       // .re_data(line_in[63:32]),   
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w2 ( //word2
        .data_out(w2),      
        .addr(index), 
        .data_in(data_in2),  
        .write(wr_word2),
        .clk(clk), 
        .rst(rst), 
        //.load(load), 
       // .re_data(line_in[95:64]),   
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w3 ( //word3
        .data_out(w3),      
        .addr(index), 
        .data_in(data_in3), 
        .write(wr_word3), 
        .clk(clk), 
        .rst(rst), 
        //.load(load), 
       // .re_data(line_in[127:96]),  
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w4 ( //word4
        .data_out(w4),      
        .addr(index), 
        .data_in(data_in4),  
        .write(wr_word4), 
        .clk(clk), 
        .rst(rst), 
        //.load(load), 
       // .re_data(line_in[159:128]), 
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w5 ( //word5
        .data_out(w5),      
        .addr(index), 
        .data_in(data_in5),  
        .write(wr_word5), 
        .clk(clk), 
        .rst(rst), 
        //.load(load), 
       // .re_data(line_in[191:160]), 
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w6 ( //word6
        .data_out(w6),      
        .addr(index), 
        .data_in(data_in6),  
        .write(wr_word6), 
        .clk(clk), 
        .rst(rst), 
        //.load(load), 
        //.re_data(line_in[223:192]), 
        .byte_w_en(byte_w_en_r));
        
   cache_word_memc mem_w7 ( //word7
        .data_out(w7),      
        .addr(index), 
        .data_in(data_in7),  
        .write(wr_word7), 
        .clk(clk), 
        .rst(rst), 
       // .load(load), 
       // .re_data(line_in[255:224]), 
        .byte_w_en(byte_w_en_r));

   memc #(20) mem_tg (
    .data_out(tag_out), 
    .addr(index), 
    .data_in(tag_in),   
    .write(wr_tag),   
    .clk(clk), 
    .rst(rst));
    
   memc #( 1) mem_dr (
    .data_out(dirtybit),
    .addr(index), 
    .data_in(dirty_in), 
    .write(wr_dirty), 
    .clk(clk), 
    .rst(rst));
    
   memv mem_vl (
    .data_out(validbit),
    .addr(index), 
    .data_in(1'b1), 
    .write(wr_valid), 
    .clk(clk),
    .rst(rst));//write = 1 and compare = 0 set valid bits

   assign            valid = go & validbit & (~write | compare);
   assign            hit = go & match & valid;// self modify
   assign            dirty = go & (~write | (compare & ~match)) & dirtybit;
   assign            data_out = /*(write | ~go)? 0 :*/
                      (word[2] ? (word[1] ? (word[0] ? w7 : w6):(word[0] ? w5 : w4)) : (word[1] ? (word[0] ? w3 : w2):(word[0] ? w1 : w0)));

   assign  			 line_out = {w7, w6, w5, w4, w3, w2, w1, w0};
 //  assign            valid = go & validbit & (~write | compare);

endmodule
