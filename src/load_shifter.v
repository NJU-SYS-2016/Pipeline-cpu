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
			    case (addr)
			        0 : data_to_reg = { { 24 {mem_data[31]} } , mem_data[31:24] }; 
			        1 : data_to_reg = { { 24 {mem_data[23]} } , mem_data[23:16] };
			        2 : data_to_reg = { { 24 {mem_data[15]} } , mem_data[15:8] };
			        3 : data_to_reg = { { 24 {mem_data[7]} } , mem_data[7:0] };
				endcase
			end
			1 : begin //lbu
			    case (addr)
                    0 : data_to_reg = { 24 'b0 , mem_data[31:24] }; 
                    1 : data_to_reg = { 24 'b0 , mem_data[23:16] };
                    2 : data_to_reg = { 24 'b0 , mem_data[15:8] };
                    3 : data_to_reg = { 24 'b0 , mem_data[7:0] };
            endcase
			end
			2 : begin //lh
			    case (addr[1])
			        0 : data_to_reg = { { 16 {mem_data[31]} } , mem_data[31:16] };
			        1 : data_to_reg = { { 16 {mem_data[15]} } , mem_data[15:0] };
			    endcase
			end
			3 : begin //lhu
			    case (addr[1])
                    0 : data_to_reg = { 16'b0 , mem_data[31:16] };
                    1 : data_to_reg = { 16'b0 , mem_data[15:0] };
                endcase
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