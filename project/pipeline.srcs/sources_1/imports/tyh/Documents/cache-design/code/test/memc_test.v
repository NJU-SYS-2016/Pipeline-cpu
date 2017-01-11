`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2016 03:40:29 PM
// Design Name: 
// Module Name: cache_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module memc_test();
   parameter size = 8;
   wire  [size-1:0]   data_out;
   reg   [6:0]        addr;
   reg   [size-1:0]   data_in;
   reg                write;
   reg                clk;
   reg                rst;
   
   memc #(size) test1(
    .data_out(data_out),
    .addr(addr),
    .data_in(data_in),
    .write(write),
    .clk(clk),
    .rst(rst));
    
    initial begin
        clk = 1;
        rst = 0;
        write = 1;
        data_in = 8'b01010101;
        addr = 7'b0;
        #15;
        
        addr = 7'b0000_001;
        #15;
        
        addr = 7'b0000_010;
        #15;
        
        addr = 7'b0000_011;
        #15;
         
        addr = 7'b0000_100;
        #15;
        
        rst = 1;
        #15;
        
    end
    
    always begin
    #10 clk = ~clk;
    end
endmodule
