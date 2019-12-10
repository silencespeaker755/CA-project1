// MUX two values of length 7 bits
module MUX7(
	input 			flush_i,
    input 			Branch_i,
    input			MemRead_i,
    input			MemtoReg_i,
    input 	[1:0]	ALUOp_i,
    input			MemWrite_i,
    input			ALUSrc_i,
	input	    	RegWrite_i,
	output	    	Branch_o,
	output	    	MemRead_o,
	output	    	MemtoReg_o,
	output 	[1:0]	ALUOp_o,
	output	    	MemWrite_o,
	output	    	ALUSrc_o,
	output	    	RegWrite_o
);


assign Branch_o 	= (flush_i) ? 	1'b0:Branch_i;
assign MemRead_o 	= (flush_i) ? 	1'b0:MemRead_i;
assign MemtoReg_o	= (flush_i) ? 	1'b0:MemtoReg_i;
assign ALUOp_o 		= (flush_i) ? 	2'b00:ALUOp_i;
assign MemWrite_o 	= (flush_i) ? 	1'b0:MemWrite_i;
assign ALUSrc_o 	= (flush_i) ? 	1'b0:ALUSrc_i;
assign RegWrite_o 	= (flush_i) ? 	1'b0:RegWrite_i;

endmodule
