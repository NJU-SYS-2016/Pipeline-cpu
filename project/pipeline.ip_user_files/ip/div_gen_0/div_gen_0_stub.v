// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Mon Jan  9 17:10:41 2017
// Host        : tyh running 64-bit Ubuntu 16.04 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/tyh/Documents/pipeline/pipeline.srcs/sources_1/ip/div_gen_0/div_gen_0_stub.v
// Design      : div_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "div_gen_v5_1_10,Vivado 2016.2" *)
module div_gen_0(aclk, s_axis_divisor_tvalid, s_axis_divisor_tdata, s_axis_dividend_tvalid, s_axis_dividend_tdata, m_axis_dout_tvalid, m_axis_dout_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_divisor_tvalid,s_axis_divisor_tdata[63:0],s_axis_dividend_tvalid,s_axis_dividend_tdata[63:0],m_axis_dout_tvalid,m_axis_dout_tdata[127:0]" */;
  input aclk;
  input s_axis_divisor_tvalid;
  input [63:0]s_axis_divisor_tdata;
  input s_axis_dividend_tvalid;
  input [63:0]s_axis_dividend_tdata;
  output m_axis_dout_tvalid;
  output [127:0]m_axis_dout_tdata;
endmodule
