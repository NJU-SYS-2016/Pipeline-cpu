`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Nanjing University Computer Science 2014
// Engineer: Jinci Chen
// 
// Create Date: 2016/12/01
// Design Name: 
// Module Name: exmem_reg
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
module pc(
    input clk,
    input reset,
    input stall,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);

initial begin
    pc_out <= 32'b0; //loader地址
end

always @(negedge clk) begin
    if (reset) begin
    	pc_out <= 32'b0; //loader地址
    end
    else if (!stall) begin
    	pc_out <= pc_in;
    end 	
end

endmodule
