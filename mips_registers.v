module mips_registers // this module to write and read from registers
(
	output reg [31:0] read_data_1, read_data_2,
	input [31:0] write_data,
	input [4:0] read_reg_1, read_reg_2, write_reg,
	input signal_reg_write, clk
);
	reg [31:0] registers [31:0];

	initial begin
		$readmemb("registers.mem", registers);
	end

			
	always@ (read_reg_1 or read_reg_2 or registers[read_reg_1] or registers[read_reg_2] or clk) begin
			if(clk == 1'b1)begin
			 read_data_1 = registers[read_reg_1];
			 read_data_2 =  registers[read_reg_2];
			 end
   end
	
   always @(negedge clk)begin
		if (signal_reg_write ==1'b1 && write_reg !=5'b00000) begin  // R[0] is a constant register so can't be written
			registers[write_reg] = write_data;
		   $writememb("res_registers.mem",registers);
		end
	end
	
endmodule