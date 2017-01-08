`timescale 1ns / 1ps

// File: pipeline.v
// The top module for the whole pipeline

module pipeline (
    // PS2 Keyboard
    input PS2_CLK,
    input PS2_DATA,

    // ddr Inouts
    inout [15:0] ddr2_dq,
    inout [1:0] ddr2_dqs_n,
    inout [1:0] ddr2_dqs_p,
    // Just to simpilfy RTL generation,
    input [7:0] SW,
    input [1:0] CLK_SEL,
    input clk_in1,         // the global clock
    input manual_clk,
    input reset_button,       // the global reset
    input [3:0] debug_sel,
    //input [7:0] intr,   // 8 hardware interruption
    //output [31:0] mem_pc_out,
    output [15:0] led,

    // ddr Outputs
    output [12:0] ddr2_addr,
    output [2:0] ddr2_ba,
    output ddr2_ras_n,
    output ddr2_cas_n,
    output ddr2_we_n,
    output [0:0] ddr2_ck_p,
    output [0:0] ddr2_ck_n,
    output [0:0] ddr2_cke,
    //output [0:0]           ddr2_cs_n,
    output [1:0] ddr2_dm,
    output [0:0] ddr2_odt,
        
    // VGA outputs
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS,

    //flash
    output flash_s,
    inout [3:0] flash_dq,

    //debug
    input BP_VALID,
    input BP_SAMPLER,
    output [6:0] seg_out,
    output [7:0] seg_ctrl
);

parameter DATA_WIDTH = 32;

////////////////////////////////////////////////////////////////////////////////
//
//
//  Signal declaration
//
////////////////////////////////////////////////////////////////////////////////

wire clk;

wire [DATA_WIDTH - 1 : 0] ic_addr;  // PC to fetch instruction
wire [DATA_WIDTH - 1 : 0] dc_addr;
wire dc_read_in;
wire dc_write_in;
wire [DATA_WIDTH - 1 : 0] data_reg;
wire [3:0] dc_byte_w_en;

reg reset_init;
reg [6:0] init_counter;
reg reset_done;
reg reset_sel;

initial begin
    reset_done <= 1;
    init_counter <= 0;
    reset_sel <= 0; //selected reset_button
end

always @(posedge clk) begin
    if(~reset_done) begin
        reset_sel = 1; // selected reset init
        init_counter <= init_counter + 1;
        if (init_counter < 15) begin
            reset_init <= 0;
        end
        else if (init_counter < 30) begin
            reset_init <= 1;
        end
        else if (init_counter < 45) begin
            reset_init <= 0;
        end
        else begin
            reset_done <= 1;
        end
    end
    else begin
        reset_sel <= 0; //selected reset_button
    end
end

wire reset = reset_sel ? reset_init : reset_button;

cpu_top cpu(
    .clk(clk),
    .reset(reset),
    .interruptions(),
    .ic_data_out(ic_data_out),
    .dc_data_out(mem_data),
    .mem_stall(mem_stall),
    .ic_addr(ic_addr),
    .dc_addr(dc_addr),
    .dc_read_in(dc_read_in),
    .dc_write_in(dc_write_in),
    .dc_byte_w_en(dc_byte_w_en),
    .data_reg(data_reg),
    .time_int_o()
);
////////////////////////////////////////////////////////////////////////////////
//
//  Memory interface
//
////////////////////////////////////////////////////////////////////////////////

wire ui_clk_from_ddr;
wire [31:0] loader_data;
wire sync_manual_clk;

wire [26:0] addr_to_mig;
wire [255:0] buffer_of_ddrctrl;
wire [127:0] data_to_mig;
reg [31:0] part_of_buffer;
wire [31:0] ci_dbg_status;
wire clk_to_ddr_pass;
wire clk_to_pixel_pass;

clock_control cc0(
    .clk_in1(clk_in1),
    .ui_clk_from_ddr(ui_clk_from_ddr),
    .SW(CLK_SEL),
    .manual_clk(manual_clk),
    .clk_to_ddr(clk_to_ddr_pass),
    .clk_to_pixel(clk_to_pixel_pass),
    .ui_clk_used(clk)
);

//==--------------------------------==
// Singals indicating keyboard state.
//==--------------------------------==
wire kb_overflow;  // High if the keycode queue is overflow.
wire kb_ready;     // High if there are keycodes in the queue.

wire flash_read_done;
wire [5:0] flash_state;

cpu_interface inst_ci  (
    // PS2
    .ps2_clk           ( PS2_CLK             ),
    .ps2_data          ( PS2_DATA            ),
    // DDR Inouts
    .ddr2_dq           ( ddr2_dq             ),
    .ddr2_dqs_n        ( ddr2_dqs_n          ),
    .ddr2_dqs_p        ( ddr2_dqs_p          ),

    // DDR Outputs
    .ddr2_addr         ( ddr2_addr           ),
    .ddr2_ba           ( ddr2_ba             ),
    .ddr2_ras_n        ( ddr2_ras_n          ),
    .ddr2_cas_n        ( ddr2_cas_n          ),
    .ddr2_we_n         ( ddr2_we_n           ),
    .ddr2_ck_p         ( ddr2_ck_p           ),
    .ddr2_ck_n         ( ddr2_ck_n           ),
    .ddr2_cke          ( ddr2_cke            ),
    .ddr2_cs_n         (                     ),
    .ddr2_dm           ( ddr2_dm             ),
    .ddr2_odt          ( ddr2_odt            ),

    // VGA
    .VGA_R             ( VGA_R               ),
    .VGA_G             ( VGA_G               ),
    .VGA_B             ( VGA_B               ),
    .VGA_HS            ( VGA_HS              ),
    .VGA_VS            ( VGA_VS              ),

    .rst               ( ~reset              ), // reset is high active in this module
    .instr_addr        ( ic_addr[31:2]        ),
    .dmem_read_in      ( dc_read_in           ),
    .dmem_write_in     ( dc_write_in           ),
    .dmem_addr         ( dc_addr   ),
    .data_from_reg     ( data_reg ),
    .dmem_byte_w_en    ( dc_byte_w_en   ),
    .clk_to_ddr_pass   ( clk_to_ddr_pass     ), // 100 MHz
    .clk_to_pixel_pass ( clk_to_pixel_pass   ),
    .clk_pipeline      ( clk                 ),

    .ui_clk_from_ddr   ( ui_clk_from_ddr     ),
    .instr_data_out    ( ic_data_out         ),
    .dmem_data_out     ( mem_data            ),
    .mem_stall         ( mem_stall           ),

    // debug
    .kb_overflow       ( kb_overflow         ),
    .kb_ready          ( kb_ready            ),
    .dbg_que_low       ( ci_dbg_status       ),
    .cache_stall       ( cache_stall         ),
    .trap_stall        ( trap_stall          ),
    .data_to_mig       ( data_to_mig         ),
    .buffer_of_ddrctrl ( buffer_of_ddrctrl   ),
    .addr_to_mig       ( addr_to_mig         ),

    // flash
    .flash_s(flash_s),
    .flash_c(flash_c),
    .flash_dq(flash_dq),
    .flash_state(flash_state),
    .flash_initiating(flash_initiating),
    .flash_reading(flash_reading),
    .flash_read_done(flash_read_done)
);

reg [31:0] hex_to_seg;
// segs used to output instruction

seg_ctrl seg_ctrl0 (
    .clk           ( clk_in1           ),
    .hex1          ( hex_to_seg[3:0]   ),
    .hex2          ( hex_to_seg[7:4]   ),
    .hex3          ( hex_to_seg[11:8]  ),
    .hex4          ( hex_to_seg[15:12] ),
    .hex5          ( hex_to_seg[19:16] ),
    .hex6          ( hex_to_seg[23:20] ),
    .hex7          ( hex_to_seg[27:24] ),
    .hex8          ( hex_to_seg[31:28] ),
    .seg_out       ( seg_out           ),
    .seg_ctrl      ( seg_ctrl          )
);

Breakpoint breakpoint (
    .valid       ( BP_VALID        ),
    .sampler     ( BP_SAMPLER      ),
    .digit_sel   ( SW[6:4]         ),
    .hex_digit   ( SW[3:0]         ),
    .pc          ( ic_addr[31:2]    ),
    .break_point ( break_point     ),
    .hit         ( break_point_hit )
);

always @ (*) begin
    case (SW[2:0])
        0: part_of_buffer = buffer_of_ddrctrl[1*32-1: 0*32];
        1: part_of_buffer = buffer_of_ddrctrl[2*32-1: 1*32];
        2: part_of_buffer = buffer_of_ddrctrl[3*32-1: 2*32];
        3: part_of_buffer = buffer_of_ddrctrl[4*32-1: 3*32];
        4: part_of_buffer = buffer_of_ddrctrl[5*32-1: 4*32];
        5: part_of_buffer = buffer_of_ddrctrl[6*32-1: 5*32];
        6: part_of_buffer = buffer_of_ddrctrl[7*32-1: 6*32];
        7: part_of_buffer = buffer_of_ddrctrl[8*32-1: 7*32];
    endcase
    case (debug_sel)
        4'b0000: hex_to_seg = ic_data_out;
        4'b0001: hex_to_seg = ic_addr;
        4'b0010: hex_to_seg = dc_addr;
        4'b0011: hex_to_seg = data_reg;
        4'b0100: hex_to_seg = 32'd0;
        4'b0101: hex_to_seg = {5'd0, addr_to_mig};
        4'b0110: hex_to_seg = data_to_mig[31:0];
        4'b0111: hex_to_seg = part_of_buffer;
        //4'b1000: hex_to_seg = dbg_reg;
        4'b1001: hex_to_seg = ci_dbg_status;
        4'b1010: hex_to_seg = break_point;
        4'b1011: hex_to_seg = mem_data;
        default: hex_to_seg = dc_addr;
    endcase
end

assign led[0]  = dc_write_in;
assign led[1]  = dc_read_in;
assign led[2]  = mem_stall;
assign led[3]  = cache_stall;
assign led[4]  = flash_read_done;
assign led[5]  = kb_overflow;
assign led[6]  = kb_ready;
assign led[7]  = break_point_hit;
assign led[8]  = flash_initiating;
assign led[9]  = flash_reading;
assign led[10] = trap_stall;
assign led[11] = 0;
assign led[12] = 0;
assign led[13] = 0;
assign led[14] = 0;
assign led[15] = 0;

endmodule
