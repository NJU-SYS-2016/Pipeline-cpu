-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Tue Jan 10 17:09:16 2017
-- Host        : tyh running 64-bit Ubuntu 16.04 LTS
-- Command     : write_vhdl -force -mode synth_stub {/home/tyh/Desktop/project
--               /project.srcs/ddr_clock_gen/ip/ddr_clock_gen/ddr_clock_gen_stub.vhdl}
-- Design      : ddr_clock_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ddr_clock_gen is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC
  );

end ddr_clock_gen;

architecture stub of ddr_clock_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clk_out1,clk_out2";
begin
end;
