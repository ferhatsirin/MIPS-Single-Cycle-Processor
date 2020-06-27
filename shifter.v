module shifter(result,reg_data,shamt,shiftCtr); // this module for shift operations
                                                    
output [31:0] result;
input [31:0] reg_data;
input [4:0] shamt;
input [1:0] shiftCtr;

reg [31:0] result;

always @ (*)begin
	if(shiftCtr == 2'b00) begin
		result =(reg_data << shamt); // left logical shift
	end  
	else if(shiftCtr == 2'b01)begin
		result =(reg_data >>shamt); //right logical shift
	end
	else if(shiftCtr == 2'b11)begin
		result =($signed(reg_data) >>>shamt); //right arithmetic shift
	end

end

endmodule
