`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2016 02:10:11 PM
// Design Name: 
// Module Name: muldiv
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


module muldiv
(
	input [3:0] Md_op,
	input [31:0] Rs_in,
	input [31:0] Rt_in,
	input Clk,
	output reg [31:0] Res_out,
	output Md_stall
);

// Md_op = 0001	op = DIV
//	   0010 op = DIVU
//	   0011 op = MFHI 
//	   0100 op = MFLO
//	   0101 op = MTHI
//	   0110 op = MTLO
//	   0111 op = MUL
//	   1000 op = MULT
//	   1001 op = MULTU

reg [31:0] Hi;
reg [31:0] Lo;

wire [63:0] mul_res, div_res;
wire div_valid;
reg [31:0] temp_out;

reg [31:0] A;
reg [31:0] B;

wire needstall = (Md_op == 4'b0111) || (Md_op == 4'b1000) || (Md_op == 4'b1001) || (Md_op == 4'b0001) || (Md_op == 4'b0010);
reg stall = 1;
reg ready = 0;

assign Md_stall = needstall && stall;

mult_gen_0 mul0 (
  .CLK(Clk),  // input wire CLK
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .P(mul_res)      // output wire [63 : 0] P
);


div_gen_0 div0 (
  .aclk(Clk),                                      // input wire aclk
  .s_axis_divisor_tvalid(1),    // input wire s_axis_divisor_tvalid
  .s_axis_divisor_tdata(B),      // input wire [31 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(1),  // input wire s_axis_dividend_tvalid
  .s_axis_dividend_tdata(A),    // input wire [31 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(div_valid),          // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(div_res)            // output wire [63 : 0] m_axis_dout_tdata
);

always @ (*) begin
    case (Md_op)
        1 : begin //div
            A = Rs_in[31] ? ~Rs_in + 32'b1 : Rs_in;
            B = Rt_in[31] ? ~Rt_in + 32'b1 : Rt_in;
            Res_out = 0;
        end
        2 : begin //divu
            A = Rs_in;
            B = Rt_in;
            Res_out = 0;
        end
        3 : begin //mfhi
            Res_out = Hi;
        end
        4 : begin //mflo
            Res_out = Lo;
        end
        5 : begin //mthi
            Res_out = 0;
        end
        6 : begin //mtlo
            Res_out = 0;
        end
        7 : begin //mul
            A = Rs_in[31] ? ~Rs_in + 32'b1 : Rs_in;
            B = Rt_in[31] ? ~Rt_in + 32'b1 : Rt_in;
            Res_out = temp_out;       
        end
        8 : begin //mult
            A = Rs_in[31] ? ~Rs_in + 32'b1 : Rs_in;
            B = Rt_in[31] ? ~Rt_in + 32'b1 : Rt_in;
            Res_out = 0;
        end
        9 : begin //multu
            A = Rs_in;
            B = Rt_in;
            Res_out = 0;
        end
        default : begin
            Res_out = 0;
        end     
    endcase
end

always @ (posedge Clk) begin
    if(ready) stall = 0;
    case (Md_op)
        1 : begin //div
            if(div_valid) begin
                ready <= 1;
                Hi <= ((Rs_in[31] & ~Rt_in[31])|(~Rs_in[31] & Rt_in[31])) ? ~div_res[31:0] + 1 : div_res[31:0];
                Lo <= ((Rs_in[31] & ~Rt_in[31])|(~Rs_in[31] & Rt_in[31])) ? ~div_res[63:32] + 1 : div_res[63:32];
            end
        end
        2 : begin //divu
            if(div_valid) begin
                ready <= 1;
                {Lo, Hi} <= div_res;
            end
        end
        3 : begin //mfhi
            stall <= 1;
            ready <= 0;
        end
        4 : begin //mflo
            stall <= 1;
            ready <= 0;
        end
        5 : begin //mthi
            stall <= 1;
            ready <= 0;
            Hi <= Rs_in;
        end
        6 : begin //mtlo
            stall <= 1;
            ready <= 0;
            Lo <= Rs_in;
        end
        7 : begin //mul
            ready <= 1;
            {Hi, temp_out} <= ((Rs_in[31] & ~Rt_in[31])|(~Rs_in[31] & Rt_in[31])) ? ~mul_res + 1 : mul_res;
        end
        8 : begin //mult
            ready <= 1;
            {Hi, Lo} <= ((Rs_in[31] & ~Rt_in[31])|(~Rs_in[31] & Rt_in[31])) ? ~mul_res + 1 : mul_res;
        end
        9 : begin //multu
            ready <= 1;
            {Hi, Lo} <=  mul_res;
        end
        default : begin
            stall <= 1;
            ready <= 0;
            temp_out <= 0;
        end     
    endcase
end

endmodule
