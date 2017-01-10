`ifndef __STATUS_VH__
`define __STATUS_VH__

`define NORMAL 3'b000
`define IC_MISS 3'b001
`define DC_MISS 3'b010
`define DC_MISS_DIRTY 3'b011
`define DOUBLE_MISS 3'b100
`define DOUBLE_MISS_DC_DIRTY 3'b101

`endif