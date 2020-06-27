module mips_data_mem (read_data, mem_address, write_data, sig_mem_read, sig_mem_write,MemCtr,clk);
                              // this module to write and read from memory
output [31:0] read_data;
input [31:0] mem_address;
input [31:0] write_data;
input [2:0] MemCtr;
input sig_mem_read;
input sig_mem_write;
input clk;

reg [31:0] data_mem  [255:0];
reg [31:0] read_data;

initial begin
	$readmemb("data.mem", data_mem);
end

always @(*) begin
	if (sig_mem_read ==1'b1 && clk == 1'b1) begin
		if(MemCtr == 3'b000)begin // lw
			read_data = data_mem[mem_address];
		end
		else if(MemCtr == 3'b001)begin // lbu
			read_data ={32{1'b0}};
			read_data ={data_mem[mem_address][7:0]};
		end
		else if(MemCtr ==3'b010)begin //lhu
			read_data ={32{1'b0}};
			read_data ={data_mem[mem_address][15:0]};
		end
	end
	
	if (sig_mem_write ==1'b1 && clk == 1'b0) begin
		if(MemCtr ==3'b100)begin // sw
	   	data_mem[mem_address] = write_data;
		end
		else if(MemCtr ==3'b101)begin // sb
		   read_data =data_mem[mem_address];
		   read_data ={write_data[7:0]};
		   data_mem[mem_address] =read_data;
		end
		else if(MemCtr ==3'b111)begin //sh
		   read_data =data_mem[mem_address];
		   read_data ={write_data[15:0]};
		   data_mem[mem_address] =read_data;
		end
	    $writememb("res_data.mem",data_mem);
  end

end

endmodule