module store_shifter (
	input [1:0] addr,
	input [2:0] store_sel,
	input [31:0] rt_data,
	output reg [31:0] real_rt_data
);

	always @ (*) begin
		case (store_sel)
			0 : begin //sb
				case (addr)
					3 : real_rt_data = rt_data << 24;
					2 : real_rt_data = rt_data << 16;
					1 : real_rt_data = rt_data << 8;
					0 : real_rt_data = rt_data;
					default : real_rt_data = rt_data;
				endcase
			end
			1 : begin //sh
				case (addr[1])
					1 : real_rt_data = rt_data << 16;
					0 : real_rt_data = rt_data;
					default : real_rt_data = rt_data;
				endcase
			end
			2 : real_rt_data = rt_data; //sw
			3 : begin //swl
				case (addr)
					3 : real_rt_data = rt_data >> 24; //store high 8 bits of rt to memory's low 8 bits
					2 : real_rt_data = rt_data >> 16; //store high 16 bits of rt to memory's low 16 bits
					1 : real_rt_data = rt_data >> 8; //store high 24 bits of rt to memory's low 24 bits
					0 : real_rt_data = rt_data; //store rt
					default : real_rt_data = rt_data;
				endcase
			end
			4 : begin //swr
				case (addr)
					3 : real_rt_data = rt_data; //store rt
					2 : real_rt_data = rt_data << 8; //store low 24 bits of rt to memory's high 24 bits
					1 : real_rt_data = rt_data << 16; //store low 16 bits of rt to memory's high 16 bits
					0 : real_rt_data = rt_data << 24; //store low 8 bits of rt to memory's high 8 bits
					default : real_rt_data = rt_data;
				endcase		
			end
			default : real_rt_data = rt_data;
		endcase
	end

endmodule