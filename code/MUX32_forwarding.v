// MUX three values of length 32 bits
module MUX32_forwarding(
    input 	[31:0]data_EX_i,
    input 	[31:0]ALUreult_MEM_i,
    input 	[31:0]RDdata_WB_i,
    input 		  select_i,
    output 	[31:0]data_o
);

assign data_o = (select_i == 2'b00) data_EX_i :
				(select_i == 2'b10) ALUreult_MEM_i :
				(select_i == 2'b01) RDdata_WB_i : 32'bz;	

endmodule