`timescale 1ns / 1ps

module direct_map_cache_test();
    reg clk;
    reg rst;
    reg enable;
    reg write;
    reg compare;
    //        input load,
    reg [19:0] tag_in;
    reg [6:0] index;
    reg [2:0] word;
    reg [31:0] data_in;
    reg [255:0] line_in;
    reg [3:0] byte_w_en;
    
    wire hit;
    wire dirty;
    wire valid;
    wire [19:0] tag_out;
    wire [31:0] data_out;
    wire [255:0] line_out;
    
    direct_mapped_cache test4(
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .write(write),
        .compare(compare),
        .tag_in(tag_in),
        .index(index),
        .word(word),
        .data_in(data_in),
        .line_in(line_in),
        .byte_w_en(byte_w_en),
        
        .hit(hit),
        .dirty(dirty),
        .valid(valid),
        .tag_out(tag_out),
        .data_out(data_out),
        .line_out(line_out));
        
   initial begin
        clk = 1;
        rst = 0;
        enable = 1;
        write = 1;
        compare = 0;
        tag_in = 20'h01000;
        index = 7'd128;
        word = 0;
        data_in = 32'h0c0c_0c0c;
        line_in = 255'h11111111_22222222_33333333_44444444_55555555_66666666_77777777_88888888;
        byte_w_en = 4'b0000;
        #20;
        
        write = 0;
        compare = 1;
        #20;
        
        word = 1;
        #20;
        
        word = 2;
        #20;
        
        word = 3;
        #20;
        
        word = 4;
        #20;
        
        tag_in = 20'h00000;
        #20;
        
        
   end
   
   always begin
   #10 clk = ~clk;
   end

endmodule
