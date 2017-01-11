`timescale 1ns / 1ps

module victim_line_decide(
	input rst,
	input enable,
	input compare,
	input [1:0] dirty,
	input [1:0] valid,

	output reg victim
	);

	initial begin
		victim = 0;
	end

	assign go = enable & ~rst & compare;

	always @(*) begin
		if(go) begin
			if(valid[0] == 0) begin
				victim = 0;
			end
			else if(valid[1] == 0) begin
				victim = 1;
			end
			else begin
				if (dirty[0] == 0) begin
					victim = 0;
				end
				else if (dirty[1] == 0) begin
					victim = 1;
				end
				else begin
					victim = 0;
				end
			end
		end
	end
endmodule
