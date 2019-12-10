module HazardDetection(
	input           MemRead_EX_i,
	input [4:0]		RS1addr_ID_i,
	input [4:0]		RS2addr_ID_i,
	input [4:0] 	RDaddr_EX_i,
	input           Branch_i,
	output 			stall_o,
	output 			PCWrite_o,
    output          IF_IDWrite_o,
    output          IDflush_o,
	output          IF_IDflush_o
);

assign stall_o      = (MemRead_EX_i && ((RS1addr_ID_i == RDaddr_EX_i) || (RS2addr_ID_i == RDaddr_EX_i))) ? 1 : 0;
assign PCWrite_o    = ~stall_o;
assign IF_IDWrite_o = ~stall_o;
assign IDflush_o    = stall_o;
assign IF_IDflush_o = Branch_i;

endmodule
