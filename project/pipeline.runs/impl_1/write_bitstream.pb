
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2�
�Input buffer inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/gen_dqs_iobuf_HR.gen_dqs_iobuf[0].gen_ddr2_or_low_dqs_diff.u_iobuf_dqs/IBUFDS/IBUFDS_S (in inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/gen_dqs_iobuf_HR.gen_dqs_iobuf[0].gen_ddr2_or_low_dqs_diff.u_iobuf_dqs macro) has no loads. It is recommended to have an input buffer drive an internal load.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2�
�Input buffer inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/gen_dqs_iobuf_HR.gen_dqs_iobuf[1].gen_ddr2_or_low_dqs_diff.u_iobuf_dqs/IBUFDS/IBUFDS_S (in inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/gen_dqs_iobuf_HR.gen_dqs_iobuf[1].gen_ddr2_or_low_dqs_diff.u_iobuf_dqs macro) has no loads. It is recommended to have an input buffer drive an internal load.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2�
�Input buffer inst_ci/sf0/IOBUF_inst_0/IBUF (in inst_ci/sf0/IOBUF_inst_0 macro) has no loads. It is recommended to have an input buffer drive an internal load.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2�
�Input buffer inst_ci/sf0/IOBUF_inst_2/IBUF (in inst_ci/sf0/IOBUF_inst_2 macro) has no loads. It is recommended to have an input buffer drive an internal load.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2�
�Input buffer inst_ci/sf0/IOBUF_inst_3/IBUF (in inst_ci/sf0/IOBUF_inst_3 macro) has no loads. It is recommended to have an input buffer drive an internal load.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
CFGBVS-12default:default2G
3Missing CFGBVS and CONFIG_VOLTAGE Design Properties2default:default2�
�Neither the CFGBVS nor CONFIG_VOLTAGE voltage property is set in the current_design.  Configuration bank voltage select (CFGBVS) must be set to VCCO or GND, and CONFIG_VOLTAGE must be set to the correct configuration voltage, in order to determine the I/O voltage support for the pins in bank 0.  It is suggested to specify these either using the 'Edit Device Properties' function in the GUI or directly in the XDC file using the following syntax:

 set_property CFGBVS value1 [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE value2 [current_design]
 #where value2 is the voltage provided to configuration bank 0

Refer to the device configuration user guide for more information.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net cpu/ID_EX/exmem_target_reg[0]_12[0] is a gated clock net sourced by a combinational pin cpu/ID_EX/alu_ctr_reg[2]_i_2/O, cell cpu/ID_EX/alu_ctr_reg[2]_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net cpu/IF_ID/idex_rd_addr_reg[4][0] is a gated clock net sourced by a combinational pin cpu/IF_ID/out_reg[4]_i_2__1/O, cell cpu/IF_ID/out_reg[4]_i_2__1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net inst_ci/u_cm_0/cache/d_cache/decide/go is a gated clock net sourced by a combinational pin inst_ci/u_cm_0/cache/d_cache/decide/victim_reg_i_2__0/O, cell inst_ci/u_cm_0/cache/d_cache/decide/victim_reg_i_2__0. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net inst_ci/u_cm_0/cache/i_cache/decide/go is a gated clock net sourced by a combinational pin inst_ci/u_cm_0/cache/i_cache/decide/victim_reg_i_2/O, cell inst_ci/u_cm_0/cache/i_cache/decide/victim_reg_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PLIDC-142default:default2C
/IDELAYCTRL REFCLK should be same as ISERDES CLK2default:default2�
�The BITSLICE cell IDELAYCTRL inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_iodelay_ctrl/u_idelayctrl_200 REFCLK pin should be driven by the same clock net as the associated ISERDES inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/ddr_byte_group_io/input_[1].iserdes_dq_.iserdesdq CLK or CLKDIV pin.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-17092default:default2*
Clock output buffering2default:default2�
�PLLE2_ADV connectivity violation. The signal inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_ddr2_infrastructure/pll_clk3_out on the inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_ddr2_infrastructure/plle2_i/CLKOUT3 pin of inst_ci/ddr_ctrl_0/m70/u_mig_7series_0_mig/u_ddr2_infrastructure/plle2_i does not drive the same kind of BUFFER load as the other CLKOUT pins. Routing from the different buffer types will not be phase aligned.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2�
�The RAMB18E1 inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram has an input control pin inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram/ADDRARDADDR[4] (net: inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/addra[0]) which is driven by a register (inst_ci/vga0/view/y_cnt_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2�
�The RAMB18E1 inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram has an input control pin inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram/ADDRARDADDR[5] (net: inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/addra[1]) which is driven by a register (inst_ci/vga0/view/y_cnt_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2�
�The RAMB18E1 inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram has an input control pin inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram/ADDRARDADDR[5] (net: inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/addra[1]) which is driven by a register (inst_ci/vga0/view/y_cnt_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2�
�The RAMB18E1 inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram has an input control pin inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram/ADDRARDADDR[6] (net: inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/addra[2]) which is driven by a register (inst_ci/vga0/view/y_cnt_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2�
�The RAMB18E1 inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram has an input control pin inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram/ADDRARDADDR[6] (net: inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/addra[2]) which is driven by a register (inst_ci/vga0/view/y_cnt_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2�
�The RAMB18E1 inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram has an input control pin inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram/ADDRARDADDR[6] (net: inst_ci/vga0/ctrl/font/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_init.ram/addra[2]) which is driven by a register (inst_ci/vga0/view/y_cnt_reg[2]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px� 
g
DRC finished with %s
1905*	planAhead2)
0 Errors, 18 Warnings2default:defaultZ12-3199h px� 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px� 
i
)Running write_bitstream with %s threads.
1750*designutils2
42default:defaultZ20-2272h px� 
?
Loading data files...
1271*designutilsZ12-1165h px� 
>
Loading site data...
1273*designutilsZ12-1167h px� 
?
Loading route data...
1272*designutilsZ12-1166h px� 
?
Processing options...
1362*designutilsZ12-1514h px� 
<
Creating bitmap...
1249*designutilsZ12-1141h px� 
7
Creating bitstream...
7*	bitstreamZ40-7h px� 
_
Writing bitstream %s...
11*	bitstream2"
./pipeline.bit2default:defaultZ40-11h px� 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px� 
s
QWebTalk data collection is enabled (User setting is ON. Install Setting is ON.).
118*projectZ1-118h px� 
�
�'%s' has been successfully sent to Xilinx on %s. For additional details about this file, please refer to the Webtalk help file at %s.
186*common2b
N/home/tyh/Documents/pipeline/pipeline.runs/impl_1/usage_statistics_webtalk.xml2default:default2,
Tue Jan 10 19:31:51 20172default:default2G
3/myFile/Vivado/2016.2/doc/webtalk_introduction.html2default:defaultZ17-186h px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2%
write_bitstream: 2default:default2
00:00:542default:default2
00:00:262default:default2
2604.3982default:default2
245.1132default:default2
18862default:default2
64902default:defaultZ17-722h px� 
e
Unable to parse hwdef file %s162*	vivadotcl2"
pipeline.hwdef2default:defaultZ4-395h px� 


End Record