module mips_testbench ();
reg clock;
wire result;

mips_core test(clock);

initial clock =1'b1;

always #10 clock =~clock; // Generate countless clock but don't have a break so be careful when testing counted instruction
                          
endmodule