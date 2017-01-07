module load_shifter (
	input [1:0] addr,
	input [2:0] load_sel,
	input [31:0] mem_data,
	output reg [31:0] data_to_reg
);

reg [31:0] temp_data;
reg [4:0] shamt;

	always@(*) begin
		case(load_sel)
			0 : begin
				shamt = addr << 3;
				temp_data = mem_data >> shamt;
				data_to_reg = { { 24{temp_data[7]} }, temp_data[7:0] };
			end
			1 : begin //lbu
				shamt = addr << 3;
				temp_data = mem_data >> shamt;
				data_to_reg = { 24'd0, temp_data[7:0] };
			end
			2 : begin //lh
				shamt = addr[1] << 4;
				temp_data = mem_data >> shamt;
				data_to_reg = { { 16{temp_data[15]} }, temp_data[15:0] };
			end
			3 : begin //lhu
				shamt = addr[1] << 4;
				temp_data = mem_data >> shamt;
				data_to_reg = { 16'b0, temp_data[15:0] };
			end
			4 : data_to_reg = mem_data; //lw
			5 : begin //lwl
				shamt = addr << 3;
				data_to_reg = mem_data << shamt;
			end
			6 : begin //lwr
				shamt = (~addr) << 3;
				data_to_reg = mem_data >> shamt;
			end
			default : data_to_reg = mem_data;
		endcase
	end

endmodule