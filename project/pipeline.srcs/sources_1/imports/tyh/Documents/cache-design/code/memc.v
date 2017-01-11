`timescale 1ns / 1ps

module memc (data_out, addr, data_in, write, clk, rst/*, load, re_data**/);
   parameter Size = 1;
   output [Size-1:0] data_out;
   input [6:0]       addr;
   input [Size-1:0]  data_in;
   input             write;
   input             clk;
   input             rst;
  // input             load;
 //  input [Size-1:0]  re_data;
 


   reg [Size-1:0]    mem [127:0];

//   integer           i;
   assign            data_out =  mem[addr];

   always @(negedge clk) begin
 /*    if (rst) begin
        for (i = 0; i < 128; i = i + 1) begin
           mem[i] = 0;
        end
     end*/

      if (!rst && write) begin
            mem[addr] = data_in;
      end
   end
endmodule
