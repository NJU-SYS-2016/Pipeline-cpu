`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2016 02:36:02 PM
// Design Name: 
// Module Name: cpu_top
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


module cpu_top(
    input clk,
    input reset,
    input [7:0] interruptions,
    input [31:0] ic_data_out,
    input [31:0] dc_data_out,
    input mem_stall,
    
    output [31:0] ic_addr,
    output [31:0] dc_addr,
    output dc_read_in,
    output dc_write_in,
    output [3:0] dc_byte_w_en,
    output [31:0] data_reg,
    output time_int_o
);

	assign dc_read_in = dc_read_in_temp & load_enable;
	assign dc_write_in = dc_write_in_temp & store_enable;
    wire dc_write_in_temp;
    wire dc_read_in_temp;

    //wire [31:0] ic_data_out;
    //wire [31:0] dc_data_out;
    //wire [31:0] ic_addr;
    //wire [31:0] dc_addr;
    //wire dc_read_in;
    //wire dc_write_in;
    //wire [3:0] dc_byte_w_en;
    //wire [31:0] data_reg;
    //wire mem_stall;
      
    wire stall;
    wire [31:0] pc_in;
    wire cu_ifid_stall;
    wire cu_ifid_flush;
    wire [31:0] pc_4;
    wire [31:0] instr;
    wire [29:0] ifid_jump_addr;
    wire [31:0] ifid_instr;
    wire [4:0] ifid_rs_addr;
    wire [4:0] ifid_rt_addr;
    wire [4:0] ifid_rd_addr;
    wire [31:0] ifid_pc;
    wire [31:0] ifid_pc_4;
    wire [15:0] ifid_imm;
    wire [4:0] cp0_src_addr;
    wire id_jump;
    wire id_nop;
    wire idex_mem_w;
    wire idex_mem_r;
    wire idex_reg_w;
    wire idex_branch;
    wire [2:0] idex_condition;
    wire idex_B_sel;
    wire [3:0] idex_ALU_op;
    wire [4:0] idex_shamt;
    wire idex_shamt_sel;
    wire [1:0] idex_shift_op;
    wire [2:0] idex_load_sel;
    wire [2:0] idex_store_sel;
    wire idex_of_w_disen;
    wire [4:0] idex_cp0_dst_addr;
    wire idex_cp0_w_en;
    wire idex_syscall;
    wire idex_eret;
    wire id_jr;
    wire [2:0] idex_exres_sel;
    wire idex_movn;
    wire idex_movz;
    wire id_rt_data_sel;
    wire [1:0] id_imm_ext;
    wire [1:0] id_rd_addr_sel;
    wire id_rt_addr_sel;
    wire cu_idex_stall;
    wire cu_idex_flush;
    wire [4:0] rt_addr;
    wire [31:0] memwb_data;
    wire [31:0] Gpr_rt_out;
    wire [31:0] cp0_data;
    wire cu_cp0_w_en;
    wire [31:0] epc;
    wire [2:0] pc_in_sel;
    wire [31:0] cu_vector;
    wire [31:0] cp0_epc;  
    wire [31:0] idex_op_A;
    wire [31:0] idex_op_B;
    wire [31:0] idex_imm_ext;
    wire [4:0] idex_rd_addr;
    wire ex_nop;
    wire ex_jmp;
    wire ex_jr;
    wire idex_movz_out;
    wire idex_movn_out;
    wire idex_mem_w_out;
    wire idex_mem_r_out;
    wire idex_reg_w_out;
    wire idex_branch_out;
    wire [2:0] idex_condition_out;
    wire idex_of_w_disen_out;
    wire [2:0] idex_exres_sel_out;
    wire idex_B_sel_out;
    wire [3:0] idex_ALU_op_out;
    wire idex_shamt_sel_out;
    wire [4:0] idex_shamt_out;
    wire [1:0] idex_shift_op_out;
    wire [31:0] idex_imm_ext_out;
    wire [4:0] idex_rd_addr_out;
    wire [31:0] idex_pc_out;
    wire [31:0] idex_pc_4_out;
    wire [2:0] idex_load_sel_out;
    wire [2:0] idex_store_sel_out;
    wire [31:0] idex_op_A_out;
    wire [31:0] idex_op_B_out;
    wire [4:0] idex_rs_addr_out;
    wire [4:0] idex_rt_addr_out;
    wire [4:0] idex_cp0_dst_addr_out;
    wire idex_cp0_w_en_out;
    wire idex_syscall_out;
    wire idex_eret_out; 
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] ALU_out;
    wire lf_out;
    wire zf_out;
    wire of_out;
    wire [31:0] mux_6_out;
    wire [31:0] mux_8_out;
    wire [4:0] shift_amount;
    wire [1:0] shift_op;
    wire [31:0] shift_out;  
    wire [31:0] adder2_out;  
    wire [31:0] mux_10_out;  
    wire [31:0] input_A_out;
    wire [31:0] input_B_out;
    wire [1:0] A_sel_out;
    wire [1:0] B_sel_out;
    wire cu_exmem_stall;
    wire cu_exmem_flush;
    wire [31:0] ex_res;
    wire [3:0] reg_byte_w_en;
    wire [3:0] mem_byte_w_en;
    wire [31:0] aligned_rt_data;
    wire [31:0] aligned_rt_data_out;
    wire mem_nop;
    wire mem_jmp;
    wire [31:0] exmem_pc_out;
    wire exmem_mem_w_out;
    wire exmem_reg_w_out;
    wire [3:0] reg_byte_w_en_out;
    wire exmem_branch_out;
    wire [2:0] exmem_condition_out;
    wire [31:0] exmem_target_out;
    wire [31:0] exmem_pc_4_out;
    wire exmem_lf_out;
    wire exmem_zf_out;
    wire [2:0] exmem_load_sel_out;
    wire [2:0] exmem_store_sel_out;
    wire [4:0] exmem_cp0_dst_addr_out;
    wire exmem_cp0_w_en_out;
    wire exmem_syscall_out;
    wire exmem_eret_out; 
    wire new_reg_w_out;
    wire [31:0] target_exmem_pc_in;
    wire [31:0] mem_data;
    wire [31:0] ex_data;
    wire memwb_mem_r_out;
    wire memwb_reg_w_out;
    wire [4:0] memwb_rd_addr_out;
    wire [3:0] memwb_reg_byte_w_en_out;
    wire [31:0] memwb_memdata_out;
    wire [31:0] memwb_exdata_out;
    wire [4:0] memwb_cp0_dst_addr_out;
    wire memwb_cp0_w_en_out;
    wire [31:0] MD_out;
    wire Md_stall;
    wire [3:0] Md_op;
    wire [3:0] idex_md_op;
    wire memwb_stall;
    wire branch_state;
    wire [31:0] mem_excepttype;
    wire delayslot;
    wire [31:0] status_o;
    wire [31:0] exmem_excepttype;
    wire idex_trap;
    wire [31:0] idex_excepttype;
    wire invalid_inst;
    wire idex_is_in_delay_slot;
    wire idex_is_in_delay_slot_out;
    wire idex_trap_out;
    wire idex_overflow_detect_out;
    wire [31:0] idex_excepttype_out;
    wire [31:0] cause_o;
    wire [4:0] exmem_rd_addr_out;
    wire [31:0] pc_out;
    wire exmem_jr_out;
    wire [31:0] exmem_alu_res_out;
    wire [31:0] exmem_excepttype_out;
    
    wire store_enable;
    wire load_enable;
    assign ic_addr = pc_out;////**************
    assign dc_addr = exmem_alu_res_out;
    
    MUX32_5 mux_0(
    .A({ifid_jump_addr,2'b00}),
    .B(cu_vector),
    .C(cp0_epc),
    .D(target_exmem_pc_in),
    .E(pc_4),
    .sel(pc_in_sel),
    .out(pc_in));
    
    pc PC(
    .stall(stall),
    .clk(clk),
    .reset(reset),
    .pc_in(pc_in),
    .pc_out(pc_out));
    
    adder adder_for_pc(
    .cin(0),
    .a_in(pc_out),
    .b_in(32'd4),
    .o_out(pc_4),
    .zero(),
    .overflow(),
    .carry(),
    .negative());
    
    ifid_reg IF_ID(
    .clk(clk),
    .reset(reset),
    .cu_stall(cu_ifid_stall),
    .cu_flush(cu_ifid_flush),
    .pc(pc_out),
    .pc_4(pc_4),
    .instr(ic_data_out),
    .ifid_jump_addr(ifid_jump_addr),
    .ifid_instr(ifid_instr),
    .ifid_rs_addr(ifid_rs_addr),
    .ifid_rt_addr(ifid_rt_addr),
    .ifid_rd_addr(ifid_rd_addr),
    .ifid_pc(ifid_pc),
    .ifid_pc_4(ifid_pc_4),
    .ifid_imm(ifid_imm));
    
    MUX5_2 mux_1(
    .A(ifid_rt_addr),
    .B(4'b0),
    .sel(id_rt_addr_sel),
    .out(rt_addr));
    
    GPR gpr(
    .clk(~clk),
    .reset(reset),
    .rs_addr(ifid_rs_addr),
    .rt_addr(rt_addr),
    .rd_in(memwb_data),
    .write(memwb_reg_w_out),
    .rd_addr(memwb_rd_addr_out),
    .rd_byte_w_en(memwb_reg_byte_w_en_out),
    .rs_out(idex_op_A),
    .rt_out(Gpr_rt_out));
    
    MUX32_2 mux_3(
    .A(cp0_data),
    .B(Gpr_rt_out),
    .sel(id_rt_data_sel),
    .out(idex_op_B));
    
    Ext_unit Eut(
    .id_imm_ext(id_imm_ext),
    .ifid_imm(ifid_imm),
    .imm_ext(idex_imm_ext));
    
    except_detect1 ED1(
    .syscall_i(idex_syscall),
    .eret(idex_eret),
    .invalid_inst_i(invalid_inst),
    .excepttype_o(idex_excepttype));
    
    decoder DC(
    .ifid_instr(ifid_instr),
    .idex_cp0_src_addr(cp0_src_addr),
    .idex_jump(id_jump),
    .idex_nop(id_nop),
    .idex_mem_w_en(idex_mem_w),
    .idex_mem_r_en(idex_mem_r),
    .idex_reg_w_en(idex_reg_w),
    .idex_branch(idex_branch),
    .idex_condition(idex_condition),
    .idex_B_sel(idex_B_sel),
    .idex_ALU_op(idex_ALU_op),
    .idex_shamt(idex_shamt),
    .idex_shamt_sel(idex_shamt_sel),
    .idex_shift_op(idex_shift_op),
    .idex_load_sel(idex_load_sel),
    .idex_store_sel(idex_store_sel),
    .idex_of_w_disen(idex_of_w_disen),
    .idex_cp0_dest_addr(idex_cp0_dst_addr),
    .idex_cp0_w_en(idex_cp0_w_en),
    .idex_syscall(idex_syscall),
    .idex_eret(idex_eret),
    .idex_jr(id_jr),
    .idex_exres_sel(idex_exres_sel),
    .idex_movn(idex_movn),
    .idex_movz(idex_movz),
    .idex_rt_data_sel(id_rt_data_sel),
    .idex_imm_ext(id_imm_ext),
    .idex_rd_addr_sel(id_rd_addr_sel),
    .idex_rt_addr_sel(id_rt_addr_sel),
    .idex_md_op(idex_md_op),
    .idex_trap(idex_trap),
    .idex_invalid(invalid_inst));
    
    control_unit cu(
    .reset(reset),
    .mem_stall(mem_stall | Md_stall),
    .id_jmp(id_jump),
    .mem_jr(exmem_jr_out),
    .idex_mem_r(idex_mem_r_out),
    .ifid_rs_addr(ifid_rs_addr),
    .ifid_real_rt_addr(rt_addr),
    .idex_real_rd_addr(idex_rd_addr_out),
    .mem_branch_state(branch_state),
    .mem_excepttype(mem_excepttype),
    .cu_pc_src(pc_in_sel),
    .cu_pc_stall(stall),
    .cu_ifid_stall(cu_ifid_stall),
    .cu_ifid_flush(cu_ifid_flush),
    .cu_idex_stall(cu_idex_stall),
    .cu_idex_flush(cu_idex_flush),
    .cu_exmem_stall(cu_exmem_stall),
    .cu_exmem_flush(cu_exmem_flush),
    .cu_memwb_stall(memwb_stall),
    .cu_vector(cu_vector));

    cp0 cp0(
    .clk(clk),
    .reset(reset),
    .w_en_i(memwb_cp0_w_en_out),
    .int_i(interruptions),
    .r_addr_i(cp0_src_addr),
    .excepttype_i(mem_excepttype),
    .current_inst_addr_i(exmem_pc_out),
    .is_in_delay_slot(delayslot), 
    .w_addr_i(memwb_cp0_dst_addr_out),
    .data_i(memwb_data),
    .data_o(cp0_data),
    .epc_o(cp0_epc),
    .status_o(status_o),
    .cause_o(cause_o),
    .time_int_o(time_int_o));
    
    MUX5_3 mux_4(
    .A(ifid_rt_addr),
    .B(ifid_rd_addr),
    .C(5'h1f),
    .sel(id_rd_addr_sel),
    .out(idex_rd_addr));
    
    idex_reg ID_EX(
    .clk(clk),
    .reset(reset),
    .cu_stall(cu_idex_stall),
    .cu_flush(cu_idex_flush),
    .id_nop(id_nop),
    .id_jmp(id_jump),
    .idex_mem_w_in(idex_mem_w),
    .idex_mem_r_in(idex_mem_r),
    .idex_reg_w_in(idex_reg_w),
    .idex_branch_in(idex_branch),
    .idex_condition_in(idex_condition),
    .idex_of_w_disen_in(idex_of_w_disen),
    .idex_exres_sel_in(idex_exres_sel),
    .idex_B_sel_in(idex_B_sel),
    .idex_ALU_op_in(idex_ALU_op),
    .idex_shamt_in(idex_shamt),
    .idex_shamt_sel_in(idex_shamt_sel),
    .idex_shift_op_in(idex_shift_op),
    .idex_imm_ext_in(idex_imm_ext),
    .idex_load_sel_in(idex_load_sel),
    .idex_store_sel_in(idex_store_sel),
    .idex_rs_addr_in(ifid_rs_addr),
    .idex_rt_addr_in(ifid_rt_addr),
    .id_instr(),
    .idex_instr(),
    .idex_cp0_dst_addr_in(idex_cp0_dst_addr),
    .idex_cp0_w_en_in(idex_cp0_w_en),
    .idex_syscall_in(idex_syscall),
    .idex_eret_in(idex_eret),
    .id_jr(id_jr),
    .id_movn(idex_movn),
    .id_movz(idex_movz),
    .id_md_op(idex_md_op),
    .idex_is_in_delayslot_in(idex_is_in_delay_slot),
    .idex_trap_in(idex_trap),
    .idex_excepttype_in(idex_excepttype),
    
    .idex_op_A_in(idex_op_A),
    .idex_op_B_in(idex_op_B),
    .idex_pc_in(ifid_pc),
    .idex_pc_4_in(ifid_pc_4),
    .idex_rd_addr_in(idex_rd_addr),
    .ex_nop(ex_nop),
    .ex_jmp(ex_jmp),
    .ex_jr(ex_jr),
    .idex_movz(idex_movz_out),
    .idex_movn(idex_movn_out),
    .idex_mem_w(idex_mem_w_out),
    .idex_mem_r(idex_mem_r_out),
    .idex_reg_w(idex_reg_w_out),
    .idex_branch(idex_branch_out),
    .idex_condition(idex_condition_out),
    .idex_of_w_disen(idex_of_w_disen_out),
    .idex_exres_sel(idex_exres_sel_out),
    .idex_B_sel(idex_B_sel_out),
    .idex_ALU_op(idex_ALU_op_out),
    .idex_shamt_sel(idex_shamt_sel_out),
    .idex_shamt(idex_shamt_out),
    .idex_shift_op(idex_shift_op_out),
    .idex_imm_ext(idex_imm_ext_out),
    .idex_rd_addr(idex_rd_addr_out),
    .idex_pc(idex_pc_out),
    .idex_pc_4(idex_pc_4_out),
    .idex_load_sel(idex_load_sel_out),
    .idex_store_sel(idex_store_sel_out),
    .idex_op_A(idex_op_A_out),
    .idex_op_B(idex_op_B_out),
    .idex_rs_addr(idex_rs_addr_out),
    .idex_rt_addr(idex_rt_addr_out),
    .idex_cp0_dst_addr(idex_cp0_dst_addr_out),
    .idex_cp0_w_en(idex_cp0_w_en_out),
    .idex_syscall(idex_syscall_out),
    .idex_eret(idex_eret_out),
    .idex_md_op(Md_op),
    .idex_is_in_delayslot_out(idex_is_in_delay_slot_out),
    .idex_trap_out(idex_trap_out),
    .idex_overflow_detect_out(idex_overflow_detect_out),
    .idex_excepttype_out(idex_excepttype_out));
    
    is_delayslot IDSLOT(
    .is_jmp(ex_jmp),
    .is_jr(ex_jr),
    .is_branch(idex_branch_out),
    .is_in_delay_slot(idex_is_in_delay_slot));
    
    MUX32_2 mux_5(
    .A(mux_6_out),
    .B(32'd0),
    .sel(idex_movz_out | idex_movn_out),
    .out(A));
    
    MUX32_2 mux_7(
    .A(mux_8_out),
    .B(idex_imm_ext_out),
    .sel(idex_B_sel_out),
    .out(B));
    
    MUX32_3 mux_6(
    .A(idex_op_A_out),
    .B(exmem_alu_res_out),
    .C(input_A_out),
    .sel(A_sel_out),
    .out(mux_6_out));
    
    MUX32_3 mux_8(
    .A(idex_op_B_out),
    .B(exmem_alu_res_out),
    .C(input_B_out),
    .sel(B_sel_out),
    .out(mux_8_out));
    
    MUX5_2 mux_9(
    .A(idex_shamt_out),
    .B(mux_6_out[4:0]),
    .sel(idex_shamt_sel_out),
    .out(shift_amount));
    
    SHIFT shifter(
    .shift_amount(shift_amount),
    .shift_op(idex_shift_op_out),
    .shift_in(mux_8_out),
    .shift_out(shift_out));
    
    ALU alu(
    .a_in(A),
    .b_in(B),
    .alu_op(idex_ALU_op_out),
    .alu_out(ALU_out),
    .less(lf_out),
    .zero(zf_out),
    .overflow_out(of_out));

    muldiv MD(
    .Md_op(Md_op),
    .Rs_in(A),
    .Rt_in(B),
    .Clk(clk),
    .Res_out(MD_out),
    .Md_stall(Md_stall));
    
    adder adder2(
    .cin(0),
    .a_in(idex_imm_ext_out << 2),
    .b_in(idex_pc_4_out),
    .o_out(adder2_out),
    .zero(),
    .overflow(),
    .carry(),
    .negative());
    
    MUX32_2 mux_10(
    .A(adder2_out),
    .B(ALU_out),
    .sel(ex_jr),
    .out(mux_10_out));
    
    MUX32_5 mux_11(
    .A(ALU_out),
    .B(shift_out),
    .C(mux_10_out),
    .D(mux_6_out),
    .E(MD_out),
    .sel(idex_exres_sel_out),
    .out(ex_res));
    
    except_detect2 ED2(
    .alu_lf(lf_out),
    .alu_of(of_out),
    .alu_zf(zf_out),
    .trap(idex_trap_out),
    .overflow_detect(idex_overflow_detect_out),
    .excepttype_in(idex_excepttype_out),
    .condition(idex_condition_out),
    .excepttype_out(exmem_excepttype));
    
    load_b_w_e_gen loader(
    .addr(ALU_out[1:0]),
    .load_sel(idex_load_sel_out),
    .b_w_en(reg_byte_w_en));
    
    store_b_w_e_gen storer(
    .addr(ALU_out[1:0]),
    .store_sel(idex_store_sel_out),
    .b_w_en(mem_byte_w_en));
    
    store_shifter ss(
    .addr(ALU_out[1:0]),
    .store_sel(idex_store_sel_out),
    .rt_data(mux_8_out),
    .real_rt_data(aligned_rt_data));
    
    FU forward_unit(
    .rs_data(idex_op_A_out),
    .rt_data(idex_op_B_out),
    .rs_addr(idex_rs_addr_out),
    .rt_addr(idex_rt_addr_out),
    .exmem_byte_en(reg_byte_w_en_out),
    .exmem_rd_addr(exmem_rd_addr_out),
    .memwb_byte_en(memwb_reg_byte_w_en_out),
    .memwb_rd_addr(memwb_rd_addr_out),
    .memwb_data(memwb_data),
    
    .input_A(input_A_out),
    .input_B(input_B_out),
    .A_sel(A_sel_out),
    .B_sel(B_sel_out));
    
    interrupt_except_handle IEH(
    .cp0_status_i(status_o),
    .cp0_cause_i(cause_o),
    .excepttype_i(exmem_excepttype_out),
    .excepttype_o(mem_excepttype),
    .store_enable(store_enable),
    .load_enable(load_enable)
    );
    
    reg_w_gen reg_w(
    .of(of_out),
    .zf(zf_out),
    .idex_movz(idex_movz_out),
    .idex_movnz(idex_movn_out),
    .idex_reg_w(idex_reg_w_out),
    .idex_of_w_disen(idex_of_w_disen_out),
    .new_reg_w(new_reg_w_out));
    
    exmem_reg EX_MEM(
    .ex_nop(ex_nop),
    .ex_jmp(ex_jmp),
    .clk(clk),
    .reset(reset),
    .cu_stall(cu_exmem_stall),
    .cu_flush(cu_exmem_flush),
    .idex_mem_w(idex_mem_w_out),
    .idex_mem_r(idex_mem_r_out),
    .idex_reg_w(new_reg_w_out),
    .idex_branch(idex_branch_out),
    .idex_condition(idex_condition_out),
    .addr_target(mux_10_out),
    .alu_lf(lf_out),
    .alu_zf(zf_out),
    .ex_res(ex_res),
    .real_rd_addr(idex_rd_addr_out),
    .idex_load_sel(idex_load_sel_out),
    .reg_byte_w_en_in(reg_byte_w_en),
    .mem_byte_w_en_in(mem_byte_w_en),
    .idex_pc(idex_pc_out),
    .idex_pc_4(idex_pc_4_out),
    .aligned_rt_data(aligned_rt_data),
    .idex_cp0_dst_addr(idex_cp0_dst_addr_out),
    .cp0_w_en_in(idex_cp0_w_en_out),
    .syscall_in(idex_syscall_out),
    .idex_eret(idex_eret_out),
    .idex_is_in_delayslot(idex_is_in_delay_slot_out),
    .excepttype_in(exmem_excepttype),
    .idex_jr(ex_jr),
    .idex_instr(),  //*****************
    .exmem_instr(),     //***************
    
    .mem_nop(),     //***********
    .mem_jmp(),     //*****************
    .exmem_pc(exmem_pc_out),
    .exmem_mem_w(dc_write_in_temp),
    .exmem_mem_r(dc_read_in_temp),
    .exmem_reg_w(exmem_reg_w_out),
    .reg_byte_w_en_out(reg_byte_w_en_out),
    .exmem_rd_addr(exmem_rd_addr_out),
    .mem_byte_w_en_out(dc_byte_w_en),
    .exmem_alu_res(exmem_alu_res_out),        ////*******************
    .exmem_aligned_rt_data(data_reg),
    .exmem_branch(exmem_branch_out),
    .exmem_condition(exmem_condition_out),
    .exmem_target(exmem_target_out),
    .exmem_pc_4(exmem_pc_4_out),
    .exmem_lf(exmem_lf_out),
    .exmem_zf(exmem_zf_out),
    .exmem_load_sel(exmem_load_sel_out),
    .exmem_cp0_dst_addr(exmem_cp0_dst_addr_out),
    .cp0_w_en_out(exmem_cp0_w_en_out),
    .syscall_out(exmem_syscall_out),
    .exmem_eret(exmem_eret_out),
    .exmem_is_in_delayslot(delayslot),
    .exmem_excepttype(exmem_excepttype_out),
    .exmem_jr(exmem_jr_out));
    
    final_target em_tar(
    .exmem_branch(exmem_branch_out),
    .exmem_condition(exmem_condition_out),
    .exmem_target(exmem_target_out),
    .exmem_pc_4(exmem_pc_4_out),
    .exmem_lf(exmem_lf_out),
    .exmem_zf(exmem_zf_out),
    .final_target(target_exmem_pc_in),
    .branch_state(branch_state));
    
    load_shifter ls(
    .addr(exmem_alu_res_out[1:0]),
    .load_sel(exmem_load_sel_out),
    .mem_data(dc_data_out),
    .data_to_reg(mem_data));
    
    memwb_reg MEM_WB(
    .clk(clk),
    .reset(reset),
    .mem_stall(memwb_stall),
    .exmem_mem_r(dc_read_in),
    .exmem_reg_w(exmem_reg_w_out),
    .reg_byte_w_en_in(reg_byte_w_en_out),
    .exmem_rd_addr(exmem_rd_addr_out),
    .mem_data(mem_data),
    .ex_data(exmem_alu_res_out),
    .exmem_cp0_dst_addr(exmem_cp0_dst_addr_out),
    .exmem_cp0_w_en(exmem_cp0_w_en_out),
    .aligned_rt_data(data_reg),
    
    .memwb_mem_r(memwb_mem_r_out),
    .memwb_reg_w(memwb_reg_w_out),
    .memwb_rd_addr(memwb_rd_addr_out),
    .reg_byte_w_en_out(memwb_reg_byte_w_en_out),
    .memwb_memdata(memwb_memdata_out),
    .memwb_exdata(memwb_exdata_out),
    .memwb_cp0_dst_addr(memwb_cp0_dst_addr_out),
    .memwb_cp0_w_en(memwb_cp0_w_en_out),
    .aligned_rt_data_out(aligned_rt_data_out));
    
    MUX32_2 mux_2(
    .B(memwb_memdata_out),
    .A(memwb_exdata_out),
    .sel(memwb_mem_r_out),
    .out(memwb_data));
endmodule
