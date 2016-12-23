module cp0(
	input 			reset,
	input			clk,
	input			w_en_i,
	input[4:0]		w_addr_i,
	input[31:0]		data_i,
	input[4:0]		r_addr_i,
	input[7:0]		int_i,
	input[31:0]		excepttype_i,
	input[31:0]		current_inst_addr_i,
	input			is_in_delay_slot,

	output reg[31:0]	data_o,
	output reg[31:0]	status_o,
	output reg[31:0]	cause_o,
	output reg[31:0]	epc_o,
	output reg			time_int_o
	);
	reg[31:0] 		cp0_mem[4:0];
	/*
	assign cp0_count 	= 	cp0_mem[0];
	assign cp0_compare 	= 	cp0_mem[1];
	assign cp0_status 	= 	cp0_mem[2];
	assign cp0_cause 	= 	cp0_mem[3];
	assign cp0_epc 		= 	cp0_mem[4];

	assign cp0_status_cu0 	= 	cp0_status[28];
	assign cp0_status_im 	= 	cp0_status[15:8];
	assign cp0_status_exl 	= 	cp0_status[1];
	assign cp0_status_ie 	= 	cp0_status[0];

	assign cp0_cause_bd 	= 	cp0_cause[31];
	assign cp0_cause_ip 	= 	cp0_cause[15:8];
	assign cp0_cause_exccode = 	cp0_cause[6:2];
	*/
	initial begin
		cp0_mem[0] 	=	32'h0;
		cp0_mem[1]	=	32'h0;
		cp0_mem[2] 	=	32'h1000ff01;
		cp0_mem[3] 	=	32'h0;
		cp0_mem[4]	=	32'h0;
	end
    always@(*) begin
        status_o = cp0_mem[2];
        cause_o = cp0_mem[3];
        epc_o = cp0_mem[4];
    end
	always@(posedge clk) begin
		if(reset == 1'b1) begin
			cp0_mem[0] 	<=	32'h0;
			cp0_mem[1]	<=	32'h0;
			cp0_mem[2] 	<=	32'h1000ff01;
			cp0_mem[3] 	<=	32'h0;
			cp0_mem[4]		<=	32'h0;
		end
		else begin
			//count寄存�?
			if(cp0_mem[0] == 32'hffffffff) begin
				cp0_mem[0] <= 32'h0;
			end
			else begin
				cp0_mem[0] <= cp0_mem[0] + 32'b1;
			end
			//compare寄存�?
			if(cp0_mem[1] != 0 && cp0_mem[1] == cp0_mem[0]) begin
				time_int_o <= 1'b1;
			end

			//mfc0 & mtc0
			if(w_en_i == 1'b1) begin
				case(r_addr_i)
					32'h9: cp0_mem[0] 	<= data_i;
					32'hb: begin cp0_mem[1] <= data_i; time_int_o <= 1'b0; end
					32'hc: cp0_mem[2] 	<= data_i;
					32'hd: cp0_mem[3] 	<= data_i;
					32'he: cp0_mem[4] 	<= data_i;
				endcase
			end
			case(r_addr_i)
				32'h9: data_o <= cp0_mem[0];
				32'hb: data_o <= cp0_mem[1];
				32'hc: data_o <= cp0_mem[2];
				32'hd: data_o <= cp0_mem[3];
				32'he: data_o <= cp0_mem[4];
				default: data_o <= 32'h0;
			endcase
			//中断
			if(int_i != 8'h0) begin
				cp0_mem[3][15:8] 	<=	int_i;
			end
			
			//异常
			if(excepttype_i != 32'h0) begin
				if( excepttype_i == 32'h1 && 
					excepttype_i == 32'h2 &&
					excepttype_i == 32'h3 &&
					excepttype_i == 32'h4 &&
					excepttype_i == 32'h5 &&
					excepttype_i == 32'h6 &&
					excepttype_i == 32'h7 &&
					excepttype_i == 32'h8) begin
						cp0_mem[2][1] <= 1'b1; 
						cp0_mem[3][6:2] <= 0;
						if(is_in_delay_slot == 1'b1) begin
							cp0_mem[3][31] <= 1;
							cp0_mem[4] <= current_inst_addr_i - 4;
						end
						else begin
							cp0_mem[3][31] <= 0;
							cp0_mem[4] <= current_inst_addr_i;
						end
					end
				else begin
					case(excepttype_i)
						32'h9:/*syscall*/begin
							cp0_mem[2][1] <= 1'b1; 
							cp0_mem[3][6:2] <= 8;
							if(is_in_delay_slot == 1'b1) begin
								cp0_mem[3][31] <= 1;
								cp0_mem[4] <= current_inst_addr_i - 4;
							end
							else begin
								cp0_mem[3][31] <= 0;
								cp0_mem[4] <= current_inst_addr_i;
							end
						end
						32'ha:/*ri*/begin
							cp0_mem[2][1] <= 1'b1; 
							cp0_mem[3][6:2] <= 10;
							if(is_in_delay_slot == 1'b1) begin
								cp0_mem[3][31] <= 1;
								cp0_mem[4] <= current_inst_addr_i - 4;
							end
							else begin
								cp0_mem[3][31] <= 0;
								cp0_mem[4] <= current_inst_addr_i;
							end
						end
						32'hb:/*ov*/begin
							cp0_mem[2][1] <= 1'b1; 
							cp0_mem[3][6:2] <= 12;
							if(is_in_delay_slot == 1'b1) begin
								cp0_mem[3][31] <= 1;
								cp0_mem[4] <= current_inst_addr_i - 4;
							end
							else begin
								cp0_mem[3][31] <= 0;
								cp0_mem[4] <= current_inst_addr_i;
							end
						end
						32'hc:/*tr*/begin
							cp0_mem[2][1] <= 1'b1; 
							cp0_mem[3][6:2] <= 13;
							if(is_in_delay_slot == 1'b1) begin
								cp0_mem[3][31] <= 1;
								cp0_mem[4] <= current_inst_addr_i - 4;
							end
							else begin
								cp0_mem[3][31] <= 0;
								cp0_mem[4] <= current_inst_addr_i;
							end
						end
						32'hd: /*eret*/cp0_mem[2][1] <= 0;
					endcase
				end
			end
		end
	end
endmodule