module mips_instr_mem(instruction,program_counter,clk); // this module to read instruction

input clk;
input [31:0] program_counter;
output [31:0] instruction;

reg [31:0] instr_mem [255:0];
reg [31:0] instruction;

initial begin
	$readmemb("instruction.mem", instr_mem);
end

always @ (posedge clk)begin
	instruction = instr_mem[program_counter];
end

endmodule