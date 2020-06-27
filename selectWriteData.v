module selectWriteData(writeData,fromALU,fromShifter,fromMem,PC,regSrc,clk);
                                // this module selects the data to write Reg
output [31:0] writeData;
input [31:0] fromALU,fromShifter,fromMem,PC;
input [1:0] regSrc;
input clk;

reg [31:0] writeData;

always @ (*) begin
	if(clk == 1'b1)begin
		if(regSrc ==2'b00)begin
			writeData =fromALU;
		end
		else if(regSrc ==2'b01) begin
			writeData =fromShifter;
		end
		else if(regSrc == 2'b10)begin
			writeData = PC + 1;
		end
		else if(regSrc ==2'b11)begin
			writeData =fromMem;
		end
	end
end

endmodule