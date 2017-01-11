`timescale 1ns / 1ps

module mem_word_test();
    wire [31:0] data_out;
    reg  [6:0]      addr;
    reg  [31:0]  data_in;
    reg            write;
    reg              clk;
    reg              rst;
    reg [3:0]  byte_w_en;
    
    cache_word_memc test3(
        .data_out(data_out),
        .addr(addr),
        .data_in(data_in),
        .write(write),
        .clk(clk),
        .rst(rst),
        .byte_w_en(byte_w_en));
        
    initial begin
        addr = 7'd127;
        data_in = 32'h0c0c_0c0c;
        write = 1;
        clk = 1;
        rst = 0;
        byte_w_en = 4'b1111;
        #15;
        
        data_in = 32'h7777_7777;
        byte_w_en = 4'b1110;
        #15;
        
        data_in = 32'h6666_6666;
        byte_w_en = 4'b1101;
        #15;
        
        data_in = 32'h5555_5555;
        byte_w_en = 4'b1100;
        #15;
        
        data_in = 32'h4444_4444;
        byte_w_en = 4'b1011;
        #15;
        
        data_in = 32'h3333_3333;
        byte_w_en = 4'b1010;
        #15;
        
        data_in = 32'h2222_2222;
        byte_w_en = 4'b1001;
        #15;
    end
    
    always begin
    #10 clk = ~clk;
    end

endmodule
