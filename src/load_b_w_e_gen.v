module load_b_w_e_gen (
	input [1:0] addr,
	input [2:0] load_sel,
	output reg [3:0] b_w_en
);
	
	always @ (*) begin
		case (load_sel)
			5 : begin	//lwl
				case (addr)
					3 : b_w_en = 4'b1000;
					2 : b_w_en = 4'b1100;
					1 : b_w_en = 4'b1110;
					0 : b_w_en = 4'b1111;
					default : b_w_en = 4'b1111;
				endcase
			end
			6 : begin	//lwr
				case (addr)
					3 : b_w_en = 4'b1111;
					2 : b_w_en = 4'b0111;
					1 : b_w_en = 4'b0011;
					0 : b_w_en = 4'b0001;
					default : b_w_en = 4'b1111;
				endcase
			end
			default : b_w_en = 4'b1111;
		endcase
	end
	
endmodule