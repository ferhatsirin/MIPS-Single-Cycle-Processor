module ALU(result,carry,overFlow,Zerobit,data1,data2,ALUCtr);
                      // this module for arithmetic operation
output [31:0] result;
output carry,overFlow, Zerobit;
input [31:0] data1,data2;
input [3:0] ALUCtr;

reg [31:0] result;
reg carry,overFlow,Zerobit;

always @(*)begin
	if(ALUCtr == 4'b0000)begin // add
		{carry, result} = data1+data2;
		 if((data1[31]&data2[31]&(~result[31])) || ((~data1[31])&(~data2[31])&result[31]) )begin
          overFlow =1'b1;
       end
       else begin
          overFlow =1'b0;
       end
   end
	else if(ALUCtr == 4'b1000)begin //sub
		 {carry,result} =data1-data2; 
       if((data1[31]&(~data2[31])&(~result[31])) || ((~data1[31])&data2[31]&result[31]) )begin
           overFlow =1'b1;
       end
       else begin
           overFlow =1'b0;
       end 
   end
	else if(ALUCtr ==4'b0001)begin // and
		result =data1 & data2;
	end
	else if(ALUCtr ==4'b0010)begin // or
		result =data1 | data2;
	end
   else if(ALUCtr ==4'b0011)begin // nor
		result =~(data1 | data2);
	end
	else if(ALUCtr ==4'b0110)begin // slt
		result ={32{1'b0}};
		result[0] = $signed(data1) < $signed(data2); 
	end
	else if(ALUCtr ==4'b0111)begin //sltu
		result ={32{1'b0}};
		result[0] =data1 < data2;
	end
	else if(ALUCtr == 4'b1001)begin // lui
		result = data2 << 16;
	end
	
	if(result =={32{1'b0}})begin
		Zerobit =1'b1;
	end
	else begin
	 Zerobit =1'b0;
	end
	
end


endmodule