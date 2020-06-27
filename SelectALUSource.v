module SelectALUSource(sourceData,fromRt,SignExt,ALUsrc);
                       //this module selects the data to send ALU
output [31:0] sourceData;
input [31:0] fromRt,SignExt;
input ALUsrc;

reg [31:0] sourceData;

always @(*)begin

	if(ALUsrc == 1'b0)begin
		sourceData =fromRt;
	end
	if(ALUsrc == 1'b1)begin
		sourceData =SignExt;
	end
end

endmodule
