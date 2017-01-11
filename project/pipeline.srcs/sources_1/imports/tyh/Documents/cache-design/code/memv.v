`timescale 1ns / 1ps

module memv (data_out, addr, data_in, write, clk, rst);
   output  data_out;
   input [6:0]       addr;
   input             data_in;
   input             write;
   input             clk;
   input             rst;
 


   reg  mem [127:0];

   integer           i;
   initial begin
     for(i = 0; i < 128; i = i + 1)
      mem[i] = 0;
   end
   assign            data_out = (write | rst)? 0 : mem[addr];

   always @(negedge clk) begin
     if (rst) begin
        for (i = 0; i < 128; i = i + 1) begin
           mem[i] = 0;
        end
     end

      if (!rst && write) begin
            mem[addr] = data_in;
      end
   end
endmodule
