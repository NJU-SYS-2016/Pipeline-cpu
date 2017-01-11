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

module memv_test();
   wire  data_out;
   reg [6:0]       addr;
   reg             data_in;
   reg            write;
   reg             clk;
   reg            rst;
   
   memv test0(
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
        data_in = 1;
        addr = 7'b0;
        #13;
        
        addr = 7'b0000_001;
        #13;
        
        addr = 7'b0000_010;
        #13;
        
        addr = 7'b0000_011;
        #13;
         
        addr = 7'b0000_100;
        #13;
        
        rst = 1;
        #13;
        
    end
    
    always begin
    #10 clk = ~clk;
    end
endmodule
