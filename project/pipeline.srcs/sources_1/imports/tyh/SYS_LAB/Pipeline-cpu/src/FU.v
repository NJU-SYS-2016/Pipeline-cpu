`timescale 1ns / 1ps


module FU(
    input [4:0] rs_addr,
    input [31:0] rs_data,
    input [4:0] rt_addr,
    input [31:0] rt_data,
    input [4:0] exmem_rd_addr,
    input [3:0] exmem_byte_en,
    input [3:0] memwb_byte_en,
    input [31:0] memwb_data,
    input [4:0] memwb_rd_addr,
    output [31:0] input_A,
    output reg [1:0] A_sel,
    output [31:0] input_B,
    output reg [1:0] B_sel
    );
    
    assign input_A[7:0]     = (memwb_byte_en[0]==1'b0)?rs_data[7:0]     :   memwb_data[7:0];
    assign input_A[15:8]    = (memwb_byte_en[1]==1'b0)?rs_data[15:8]    :   memwb_data[15:8];
    assign input_A[23:16]   = (memwb_byte_en[2]==1'b0)?rs_data[23:16]   :   memwb_data[23:16];
    assign input_A[31:24]   = (memwb_byte_en[3]==1'b0)?rs_data[31:24]   :   memwb_data[31:24];
    
    assign input_B[7:0]     = (memwb_byte_en[0]==1'b0)?rt_data[7:0]     :   memwb_data[7:0];
    assign input_B[15:8]    = (memwb_byte_en[1]==1'b0)?rt_data[15:8]    :   memwb_data[15:8];
    assign input_B[23:16]   = (memwb_byte_en[2]==1'b0)?rt_data[23:16]   :   memwb_data[23:16];
    assign input_B[31:24]   = (memwb_byte_en[3]==1'b0)?rt_data[31:24]   :   memwb_data[31:24];
    
    always @ (*)
    begin
        if( (rs_addr == exmem_rd_addr) &&(exmem_byte_en!=4'b0000) )
            A_sel = 1;
        else if( (rs_addr == memwb_rd_addr) &&(memwb_byte_en!=4'b0000) )
            A_sel = 2;
        else
            A_sel = 0;
    end
    
    always @ (*)
    begin
        if( (rt_addr == exmem_rd_addr) &&(exmem_byte_en!=4'b0000) )
            B_sel = 1;
        else if( (rt_addr == memwb_rd_addr) &&(memwb_byte_en!=4'b0000) )
            B_sel = 2;
        else
            B_sel = 0;
    end
    
endmodule