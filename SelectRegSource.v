module SelectRegSource(write_reg,Regrt,Regrd,RegDst);
                            // this module selects the register to be written
output [4:0] write_reg;

input [4:0] Regrt,Regrd;
input RegDst;

reg [4:0] write_reg;

always @(*)begin
	if(RegDst ==1'b0)begin
		write_reg =Regrt;
	end
	if(RegDst ==1'b1)begin
		write_reg =Regrd;
	end
end

endmodule
