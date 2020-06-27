module SignExtender(extended,unextended);
                    // this module extends 16 bits data to 32 bits as signed
input [15:0] unextended;

output [31:0] extended;
reg [31:0] extended;

always @(*)begin
	extended = { {16{unextended[15]}}, unextended[15:0]};
end

endmodule