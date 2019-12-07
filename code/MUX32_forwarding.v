// MUX three values of length 32 bits
module MUX32_forwarding(
<<<<<<< HEAD
    input 	[31:0]		data_EX_i,
    input 	[31:0]		ALUreult_MEM_i,
    input 	[31:0]		RDdata_WB_i,
    input 	[1:0]	  		select_i,
    output 	[31:0]		data_o
);

assign data_o = (select_i == 2'b00) ? data_EX_i :
				(select_i == 2'b10) ? ALUreult_MEM_i :
				(select_i == 2'b01) ? RDdata_WB_i : 32'bz;	
=======
    input 	[31:0]data_EX_i,
    input 	[31:0]ALUreult_MEM_i,
    input 	[31:0]RDdata_WB_i,
    input   [1:0]select_i,
    output 	[31:0]data_o
);

assign data_o = (select_i == 2'b00)? data_EX_i:
				(select_i == 2'b10)? ALUreult_MEM_i:
				(select_i == 2'b01)? RDdata_WB_i: 
                32'bz;	
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261

endmodule
