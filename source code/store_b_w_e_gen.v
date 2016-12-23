module store_b_w_e_gen (
	input [1:0] addr,
	input [2:0] store_sel,
	output reg [3:0] b_w_en
);
	
	always @ (*) begin
		case (store_sel)
			0 : begin //sb
				case (addr)
					3 : b_w_en = 4'b0001;
					2 : b_w_en = 4'b0010;
					1 : b_w_en = 4'b0100;
					0 : b_w_en = 4'b1000;
					default : b_w_en = 4'b1111;
				endcase
			end
			1 : begin //sh
				case (addr[1])
					1 : b_w_en = 4'b0011;
					0 : b_w_en = 4'b1100;
					default : b_w_en = 4'b1111;
				endcase
			end
			2 : b_w_en = 4'b1111; //sw
			3 : begin //swl
				case (addr)
					3 : b_w_en = 4'b0001;
					2 : b_w_en = 4'b0011;
					1 : b_w_en = 4'b0111;
					0 : b_w_en = 4'b1111;
					default : b_w_en = 4'b1111;
				endcase
			end
			4 : begin //swr
				case (addr)
					3 : b_w_en = 4'b1111;
					2 : b_w_en = 4'b1110;
					1 : b_w_en = 4'b1100;
					0 : b_w_en = 4'b1000;
					default : b_w_en = 4'b1111;
				endcase
			end
			default : b_w_en = 4'b1111;
		endcase
	end
	
endmodule