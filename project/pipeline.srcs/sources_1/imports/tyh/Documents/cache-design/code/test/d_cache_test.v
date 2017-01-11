`timescale 1ns / 1ps

module d_cache_test();
    reg clk;
    reg rst;
    reg enable;
    reg write;
    reg compare;
    //input load,
    reg [31:0] addr;
    reg [31:0] data_in;
    reg [255:0] line_in;
    reg [3:0] byte_w_en;
    
    wire hit;
    wire dirty;
    wire valid;
    wire [19:0] tag_out;
    wire [31:0] data_out;
    wire [255:0] line_out;
    
    two_ways_cache test5(
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .write(write),
        .compare(compare),
        .addr(addr),
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
    addr = 32'h0100_0000;
    data_in = 32'h9999_9999;
    line_in = 255'h11111111_22222222_33333333_44444444_55555555_66666666_77777777_88888888;
    byte_w_en = 4'b0000;
    #20;
    
    
    write = 0;
    compare = 1;
    addr = 32'h0100_0000;
    #20;
    
    write = 1;
    compare = 0;
    addr = 32'h0200_0000;
    line_in = 255'h99999999_aaaaaaaa_bbbbbbbb_cccccccc_dddddddd_eeeeeeee_ffffffff_00000000;
    #20;
    

    write = 0;
    compare = 1;
    addr = 32'h0200_0000;
    #20;
    
    addr = 32'h0200_0004;
    #20;
    
    addr = 32'h0100_0004;
    #20;
   end
   
   always begin
    #10 clk = ~clk;
   end
endmodule
