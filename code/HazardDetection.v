module HazardDetection(
	input MemRead_EX_i,
	input [4:0]	RS1addr_ID_i,
	input [4:0]	RS2addr_ID_i,
	input [4:0] RDaddr_EX_i,
	output PCupdate_o,
	output Hazard_o,
	output stall_o
);

assign Hazard_o = (MemRead_EX_i && ((RS1addr_ID_i == RDaddr_EX_i) || (RS2addr_ID_i == RDaddr_EX_i))) ? 1'b1 : 1'b0;
assign stall_o = Hazard_o;
assign PCupdate_o = ~Hazard_o;


endmodule