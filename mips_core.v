module mips_core(clock); // connects all modules
input clock;

wire [31:0] instruction;
wire [31:0] write_data,read_data_1,read_data_2;
wire [4:0] write_reg, read_reg_1, read_reg_2;
wire [15:0] immed; 
wire [5:0] OPcode,funct;
wire [3:0] ALUctr;
wire [2:0] MemCtr;
wire [1:0] shiftCtr,regSrc;
wire ALUSrc,signal_reg_write,mem_read,mem_write,RegDst,beq,bne,jump,jumpCtr;
wire [31:0] fromALU,fromShifter,fromMem,sourceData,signExtended;
wire overFlow,carry,ZeroBit;
wire [4:0] shamt, Regrd;
reg [27:0] JAddress;

reg [31:0] PC;

assign read_reg_1 = instruction[25:21];
assign read_reg_2 = instruction[20:16]; //rt
assign Regrd = ( (jump ==1'b1) && (jumpCtr == 1'b0))? 5'b11111:instruction[15:11] ; // if JumpCtr is jal then rd is R[31] otherwise rd is ins[15:11]
assign immed =instruction[15:0];
assign OPcode =instruction[31:26];
assign funct =instruction[5:0];
assign shamt =instruction[10:6];

mips_instr_mem instr(instruction,PC,clock);
mips_registers registers(read_data_1,read_data_2,write_data,read_reg_1,read_reg_2,write_reg,signal_reg_write, clock);
controlUnit u0(ALUctr,shiftCtr,MemCtr,ALUSrc,beq,bne,jump,jumpCtr,signal_reg_write,mem_read,mem_write,regSrc,RegDst,OPcode,funct);
SignExtender u2(signExtended,immed);
SelectALUSource u3(sourceData,read_data_2,signExtended,ALUSrc);
ALU u4(fromALU,carry,overFlow,ZeroBit,read_data_1,sourceData,ALUctr);
shifter u5(fromShifter,read_data_2,shamt,shiftCtr);
mips_data_mem u6(fromMem,fromALU,read_data_2,mem_read,mem_write,MemCtr,clock);
SelectRegSource u1(write_reg,read_reg_2,Regrd,RegDst);
selectWriteData u7(write_data,fromALU,fromShifter,fromMem,PC,regSrc,clock);

always @(negedge clock)begin

	PC =PC + 1;
	
	if(beq==1'b1 && ZeroBit==1'b1)begin 
	   PC = PC +signExtended;
	end
	if(bne == 1'b1 && ZeroBit == 1'b0)begin
		PC =PC +signExtended;
	end
	if(jump == 1'b1)begin
		if(jumpCtr == 1'b0)begin // j and jal
			JAddress ={32{1'b0}};
			JAddress = {instruction[25:0]};
			PC = {PC[31:28],JAddress};
		end
		if(jumpCtr == 1'b1)begin // jr
		   PC = read_data_1; // R[rs]
		end
	end
end

initial begin
	$monitor("ins %32b rs %5b $rs: %32b, rt: %5b,  $rt %32b rd: %5b WriteData %32b, carry %b overFlow %b",instruction,read_reg_1,read_data_1,read_reg_2,read_data_2,write_reg,write_data,carry,overFlow);
	PC ={32{1'b0}};
end


endmodule