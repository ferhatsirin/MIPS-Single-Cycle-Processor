module controlUnit(ALUctr,shiftCtr,MemCtr,ALUSrc,beq,bne,jump,JumpCtr,reg_write,mem_read,mem_write,RegSrc,RegDst,OPcode,funct);
                        // this module sets the control unit parameters according to the instruction
input [5:0] OPcode,funct;
output [3:0] ALUctr;
output [2:0] MemCtr;
output [1:0] shiftCtr,RegSrc;
output reg_write,mem_write,mem_read,RegDst,beq,bne,ALUSrc,jump,JumpCtr;

reg [3:0] ALUctr;
reg [1:0] shiftCtr, RegSrc;
reg [2:0] MemCtr;
reg ALUSrc, reg_write,mem_read,mem_write,RegDst,beq,bne;
reg jump,JumpCtr;

// ALUCtr add 0000 sub 1000 and 0001 or 0010 nor 0011  slt 0110 sltu 0111 lui 1001
// Memctr 000 lw 001 lbu 010 lhu 100 sw 101 sb 111 sh
// shiftCtr 00 sll 01 srl 11 sra
// RegDst 1 -> $rd 0 -> $rt
// ALUSrc 1 -> SignExtImm. 0 -> $rt
// RegSrc 00 -> from ALU to reg 01 -> from shifter 11 -> from mem 
always @(*)begin
	if(OPcode == 6'b000000)begin  // R type instructions control signals
		if(funct == 6'b100000)begin // add
			ALUctr =4'b0000; // add
			ALUSrc =1'b0; // $rt
			RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
	   else if(funct == 6'b100001 )begin //addu
			ALUctr =4'b0000; // add 
		   ALUSrc =1'b0; // $rt
			RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b100100)begin //and
			ALUctr =4'b0001;  
			ALUSrc =1'b0; // $rt
			RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
		   beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b001000)begin // jr 
			JumpCtr =1'b1;
			reg_write =1'b0;
			mem_read =1'b0;
			mem_read =1'b0;
		   beq =1'b0;
			bne =1'b0;
			jump =1'b1;
		end
		else if(funct == 6'b100111)begin // nor
			ALUctr =4'b0011;
			ALUSrc =1'b0; // $rt
		   RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b100101)begin //or
			ALUctr =4'b0010;
			ALUSrc =1'b0; // $rt
		   RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
	   end
		else if(funct == 6'b101010)begin // slt
			ALUctr =4'b0110;
			ALUSrc =1'b0; // $rt
			RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b101011)begin //sltu
			ALUctr =4'b0111;
			ALUSrc =1'b0; // $rt
			RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
		   beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
	   else if(funct == 6'b100010)begin //sub
			ALUctr =4'b1000;
			ALUSrc =1'b0; // $rt
			RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b100011)begin //subu
			ALUctr =4'b1000;
			ALUSrc =1'b0; // $rt
	    	RegSrc =2'b00; // from ALU
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b000000)begin //sll
			shiftCtr =2'b00;
			RegSrc =2'b01; // from Shifter
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
			beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b000010)begin // srl
			shiftCtr =2'b01;
			RegSrc =2'b01; // from Shifter
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
		   beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
		else if(funct == 6'b000011)begin //sra
			shiftCtr =2'b11;
			RegSrc =2'b01; // from Shifter
			RegDst =1'b1;  // $rd
			reg_write =1'b1;
			mem_read =1'b0;
			mem_write =1'b0;
		   beq =1'b0;
			bne =1'b0;
			jump =1'b0;
		end
	end                // I and J type instructions control signals 
	else if(OPcode == 6'b001000)begin // addi
		ALUctr =4'b0000;
		ALUSrc =1'b1; // SignExtImm.
		RegSrc =2'b00; // from ALU
	   RegDst =1'b0;  // $rt
		reg_write =1'b1;
	   mem_read =1'b0;
	   mem_write =1'b0;
	   beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode == 6'b001001)begin // addiu
		ALUctr =4'b0000;
		ALUSrc =1'b1; // SignExtImm
		RegSrc =2'b00; // from ALU
	   RegDst =1'b0;  // $rt
		reg_write =1'b1;
	   mem_read =1'b0;
	   mem_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode == 6'b001100)begin // andi
		ALUctr =4'b0001; 
		ALUSrc =1'b1; // SignExtImm
		RegSrc =2'b00; // from ALU
	   RegDst =1'b0;  // $rt
		reg_write =1'b1;
	   mem_read =1'b0;
	   mem_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b000100)begin //beq
		ALUctr =4'b1000; //sub
		ALUSrc =1'b0; // $rt
		reg_write =1'b0;
		mem_read =1'b0;
		mem_write =1'b0;
		beq =1'b1;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b000101)begin // bne
		ALUctr =4'b1000;
		ALUSrc =1'b0; //$rt
		reg_write =1'b0;
		mem_read =1'b0;
		mem_write =1'b0;
	   beq =1'b0;
    	bne =1'b1;
		jump =1'b0;
	end
	else if(OPcode ==6'b100100)begin // lbu
		MemCtr =3'b001;
		ALUctr =4'b0000; //add 
		ALUSrc =1'b1; // SignExtImm.
		RegSrc =2'b11; // fromMEM
		RegDst =1'b0; // $rt
		mem_read =1'b1;
		mem_write =1'b0;
		reg_write =1'b1;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b100101)begin //lhu
		MemCtr =3'b010;
		ALUctr =4'b0000; //add
		ALUSrc =1'b1; // SignExtImm.
 		RegSrc =2'b11; // fromMem
		RegDst =1'b0; //$rt
		reg_write =1'b1;
		mem_read =1'b1;
		mem_write =1'b0;
	   beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b001111)begin //lui
		ALUctr =4'b1001;
		ALUSrc =1'b1; //SignExtImm.
		RegSrc =2'b00; //fromALU
		RegDst =1'b0; // $rt
		reg_write =1'b1;
		beq =1'b0;
    	bne =1'b0;
		mem_read =1'b0;
		mem_write =1'b0;
		jump =1'b0;
   end
   else if(OPcode ==6'b100011)begin // lw
		MemCtr =3'b000;
		ALUctr =4'b0000; //add
		ALUSrc =1'b1; // SignExtImm.
		RegSrc =2'b11; // from Mem
		RegDst =1'b0; // $rt
		reg_write =1'b1;
		mem_read =1'b1;
		mem_write =1'b0;
	   beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b001101)begin //ori
		ALUctr =4'b0010; //or
		ALUSrc =1'b1; //SignExtImm.
		RegSrc =2'b00; // from ALU
	   RegDst =1'b0;  // $rt
		reg_write =1'b1;
	   mem_read =1'b0;
	   mem_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b001010)begin //slti
		ALUctr =4'b0110; //slt
		ALUSrc =1'b1; //SignExtImm.
		RegSrc =2'b00; // from ALU
	   RegDst =1'b0;  // $rt
		reg_write =1'b1;
	   mem_read =1'b0;
	   mem_write =1'b0;
	   beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b001011)begin //sltiu
		ALUctr =4'b0111; //sltu
		ALUSrc =1'b1; //SignExtImm.
	   RegSrc =2'b00; // from ALU
	   RegDst =1'b0;  // $rt
		reg_write =1'b1;
	   mem_read =1'b0;
	   mem_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b101000)begin // sb
		MemCtr =3'b101;
		ALUctr =4'b0000; //add
		ALUSrc =1'b1; //SignExtImm.
		mem_write =1'b1;
		mem_read =1'b0;
		reg_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
   else if(OPcode ==6'b101001)begin //sh	
		MemCtr =3'b111;
		ALUctr =4'b0000; //add
		ALUSrc =1'b1; //SignExtImm.
		mem_write =1'b1;
		mem_read =1'b0;
		reg_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
   end
	else if(OPcode ==6'b101011)begin //sw
		MemCtr =3'b100;
		ALUctr =4'b0000; //add
		ALUSrc =1'b1; //SignExtImm.
		mem_read =1'b0;
		mem_write =1'b1;
		reg_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
		jump =1'b0;
	end
	else if(OPcode ==6'b000010)begin // j
	   JumpCtr =1'b0;
		jump =1'b1;
		beq =1'b0;
    	bne =1'b0;
		reg_write =1'b0;
		mem_read =1'b0;
		mem_write =1'b0;
	end
	else if(OPcode ==6'b000011)begin // jal
		JumpCtr =1'b0;
		jump =1'b1;
		reg_write =1'b1;
		RegSrc =2'b10; // PC +1 
		RegDst =1'b1; // rd
		mem_read =1'b0;
		mem_write =1'b0;
		beq =1'b0;
    	bne =1'b0;
	
	end
end

endmodule



