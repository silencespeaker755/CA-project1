module Forwarding(
	input 			RegWrite_EX_MEM,
    input 			RegWrite_MEM_WB,
    input 	[4:0]	RS1addr_ID_EX_i,
    input 	[4:0]	RS2addr_ID_EX_i,
    input 	[4:0]	RDaddr_EX_MEM_i,
    input 	[4:0]	RDaddr_MEM_WB_i,
    output 	[1:0]	ALUSrc1_select_o,
    output 	[1:0]	ALUSrc2_select_o
);

assign ALUSrc1_select_o    =   (RegWrite_EX_MEM && (RDaddr_EX_MEM_i != 5'b0) && (RDaddr_EX_MEM_i == RS1addr_ID_EX_i))? 2'b10 : (RegWrite_MEM_WB && (RDaddr_MEM_WB_i != 5'b0) && !(RegWrite_EX_MEM && (RDaddr_EX_MEM_i != 5'b0) && (RDaddr_EX_MEM_i == RS1addr_ID_EX_i)) && (RDaddr_MEM_WB_i == RS1addr_ID_EX_i))? 2'b01 : 2'b00;

assign ALUSrc2_select_o    =   (RegWrite_EX_MEM && (RDaddr_EX_MEM_i != 5'b0) && (RDaddr_EX_MEM_i == RS2addr_ID_EX_i))? 2'b10 : (RegWrite_MEM_WB && (RDaddr_MEM_WB_i != 5'b0) && !(RegWrite_EX_MEM && (RDaddr_EX_MEM_i != 5'b0) && (RDaddr_EX_MEM_i == RS2addr_ID_EX_i)) && (RDaddr_MEM_WB_i == RS2addr_ID_EX_i))? 2'b01 : 2'b00;


endmodule
