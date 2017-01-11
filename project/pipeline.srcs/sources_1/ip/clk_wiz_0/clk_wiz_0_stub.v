// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Tue Apr 19 12:44:16 2016
// Host        : zyy-GE60-0NC-GE60-0ND running 64-bit Ubuntu 15.10
// Command     : write_verilog -force -mode synth_stub
//               /home/zyy/.vivado_run/pipeline_2.0/pipeline_2.0.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_in1, clk_out1, resetn, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,resetn,locked" */;
  input clk_in1;
  output clk_out1;
  input resetn;
  output locked;
endmodule
