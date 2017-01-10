module interrupt_except_handle(
		input[31:0] 		cp0_status_i,
		input[31:0] 		cp0_cause_i,
		input[31:0]			excepttype_i,
		//编码转换
		output reg [31:0]			excepttype_o,

		//访存限制
		output reg 			store_enable,
		output reg 			load_enable
	);
	//中断处理
	wire[31:0] 	excepttype;
	assign excepttype[31:8] = excepttype_i[31:8];
	//interrupt 7~0
	assign excepttype[7] = cp0_cause_i[15] & cp0_status_i[15] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[6] = cp0_cause_i[14] & cp0_status_i[14] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[5] = cp0_cause_i[13] & cp0_status_i[13] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[4] = cp0_cause_i[12] & cp0_status_i[12] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[3] = cp0_cause_i[11] & cp0_status_i[11] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[2] = cp0_cause_i[10] & cp0_status_i[10] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[1] = cp0_cause_i[9] & cp0_status_i[9] & !cp0_status_i[1] & cp0_status_i[0];
	assign excepttype[0] = cp0_cause_i[8] & cp0_status_i[8] & !cp0_status_i[1] & cp0_status_i[0];

	always@(*) begin
		store_enable <= 1'b0;
		load_enable <= 1'b0;
		if(excepttype[0] == 1'b1) begin
			excepttype_o <= 32'h1;
		end
		else if (excepttype[1] == 1'b1) begin
			excepttype_o <= 32'h2;
		end
		else if (excepttype[2] == 1'b1) begin
			excepttype_o <= 32'h3;
		end
		else if (excepttype[3] == 1'b1) begin
			excepttype_o <= 32'h4;
		end
		else if (excepttype[4] == 1'b1) begin
			excepttype_o <= 32'h5;
		end
		else if (excepttype[5] == 1'b1) begin
			excepttype_o <= 32'h6;
		end
		else if (excepttype[6] == 1'b1) begin
			excepttype_o <= 32'h7;
		end
		else if (excepttype[7] == 1'b1) begin
			excepttype_o <= 32'h8;
		end
		else if (excepttype[8] == 1'b1) begin
			excepttype_o <= 32'h9;
		end
		else if (excepttype[9] == 1'b1) begin
			excepttype_o <= 32'ha;
		end
		else if (excepttype[10] == 1'b1) begin
			excepttype_o <= 32'hb;
		end
		else if (excepttype[11] == 1'b1) begin
			excepttype_o <= 32'hc;
		end
		else if (excepttype[12] == 1'b1) begin
			excepttype_o <= 32'hd;
		end
		else begin
			excepttype_o <= 32'h0;
			store_enable <= 1'b1;
			load_enable <= 1'b1;
		end
	end


endmodule