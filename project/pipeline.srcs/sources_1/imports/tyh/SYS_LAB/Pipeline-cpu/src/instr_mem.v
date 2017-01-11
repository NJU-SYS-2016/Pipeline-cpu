`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/21 00:07:19
// Design Name: 
// Module Name: instr_mem
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


module instr_mem
#(parameter RAM_WIDTH = 32,parameter RAM_ADDR_BITS = 11)
(
    input clk,
    input w_en,
    input [RAM_ADDR_BITS-1:0] pc,
    input [RAM_WIDTH-1:0] data_in,
    output [RAM_WIDTH-1:0] instr
);

(* ram_style="distributed" *)
reg [RAM_WIDTH-1:0] regs [(2**RAM_ADDR_BITS)-1:0];
initial begin
    $readmemh("/home/tyh/Documents/ram.txt",regs);
end

always @(negedge clk)
    if (w_en)
        regs[pc] <= data_in;
assign instr = regs[pc];

endmodule