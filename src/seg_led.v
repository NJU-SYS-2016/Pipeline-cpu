// `define		pc_sw_no			14
// `define		inst_sw_no			13
// `define		excepttype_sw_no	12

module hex_to_led(
		input[3:0]			number,
		output reg[6:0]		led_seg
	);
	always@(*) begin
		case(number)
			4'h0:led_seg = 7'b1000000;
			4'h1:led_seg = 7'b1111001;
			4'h2:led_seg = 7'b0100100;
			4'h3:led_seg = 7'b0110000;
			4'h4:led_seg = 7'b0011001;
			4'h5:led_seg = 7'b0010010;
			4'h6:led_seg = 7'b0000010;
			4'h7:led_seg = 7'b1111000;
			4'h8:led_seg = 7'b0000000;
			4'h9:led_seg = 7'b0010000;
			4'ha:led_seg = 7'b0001000;
			4'hb:led_seg = 7'b0000011;
			4'hc:led_seg = 7'b1000110;
			4'hd:led_seg = 7'b0100001;
			4'he:led_seg = 7'b0000110;
			4'hf:led_seg = 7'b0001110;
			default:led_seg = 7'b1000111;
		endcase
	end
endmodule

module frequency_divider_led(
				input			clk,
				output reg		fre_clk 
		);
	reg[31:0]		cnt;
	initial begin
		fre_clk = 0;
		cnt = 0;
	end
	always@(posedge clk) begin
		if(cnt == 100000) begin
			fre_clk = ~fre_clk;
			cnt = 0;
		end
		else begin
			cnt = cnt + 1'b1;
		end
	end
endmodule

module top_led(
		input				clk,
		input[31:0]			show_info,
		output reg[7:0]		sel_seg,
		output reg[6:0]		led_seg
	);
	wire[6:0]	led[7:0];
	wire		led_clk;
	initial begin
		sel_seg = 0;
	end
	frequency_divider_led frequency_divider_led0( .clk(clk), 	.fre_clk(led_clk) );
	hex_to_led	hex_to_led0(show_info[31:28], led[7]);
	hex_to_led 	hex_to_led1(show_info[27:24], led[6]);
	hex_to_led 	hex_to_led2(show_info[23:20], led[5]);
	hex_to_led 	hex_to_led3(show_info[19:16], led[4]);
	hex_to_led  hex_to_led4(show_info[15:12], led[3]);
	hex_to_led 	hex_to_led5(show_info[11:8], led[2]);
	hex_to_led 	hex_to_led6(show_info[7:4], led[1]);
	hex_to_led 	hex_to_led7(show_info[3:0], led[0]);
	always@(posedge led_clk) begin
		case(sel_seg)
			8'b11111110:begin
				sel_seg <= 8'b11111101;
				led_seg <= led[1];
			end
			8'b11111101:begin
				sel_seg <= 8'b11111011;
				led_seg <= led[2];
			end
			8'b11111011:begin
				sel_seg <= 8'b11110111;
				led_seg <= led[3];
			end
			8'b11110111:begin
				sel_seg <= 8'b11101111;
				led_seg	<= led[4];
			end
			8'b11101111:begin
				sel_seg <= 8'b11011111;
				led_seg	<= led[5];
			end
			8'b11011111:begin
				sel_seg <= 8'b10111111;
				led_seg	<= led[6];
			end
			8'b10111111:begin
				sel_seg <= 8'b01111111;
				led_seg	<= led[7];
			end
			8'b01111111:begin
				sel_seg <= 8'b11111110;
				led_seg	<= led[0];
			end
			default:begin
				sel_seg <= 8'b11111110;
				led_seg	<= led[0];
			end
		endcase
	end
endmodule

module led_show_info(
				input				clk,
				input[15:0]			sw,
				//show infos
				input[31:0]			pc,
				input[31:0]			inst,
				input[31:0]			excepttype,

				output[7:0]		sel_seg,
				output[6:0]		led_seg
	);
	reg[31:0]		show_info;
	always@(*)begin
		if(sw[14] == 1'b1)
			show_info = pc;
		else if(sw[13] == 1'b1)
			show_info = inst;
		else if(sw[12] == 1'b1)
			show_info = excepttype;
		else begin
			show_info = 32'h0;
		end
	end
	top_led		top_led0(.clk(clk), .show_info(show_info), .sel_seg(sel_seg), .led_seg(led_seg));
endmodule

module all_top(
		input			clk,
		input[15:0]		sw,
		output[7:0]	sel_seg,
		output[6:0]	led_seg		
		);
		wire[31:0]	pc, inst, excepttype;
		assign pc = 32'habbc1245;
		assign inst = 32'h12345678;
		assign excepttype = 32'habcdef12;
		led_show_info	led_show_info0(clk, sw, pc, inst, excepttype, sel_seg, led_seg);
	
endmodule