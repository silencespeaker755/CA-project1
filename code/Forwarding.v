module Forwarding(
	input 			EX_MEM_RegWrite,
    input 			MEM_WB_RegWrite,
    input 	[4:0]	ID_EX_RS1addr_i,
    input 	[4:0]	ID_EX_RS2addr_i,
    input 	[4:0]	EX_MEM_RDaddr_i,
    input 	[4:0]	MEM_WB_RDaddr_i,
    output 	[1:0]	ALUSrc1_select_o,
    output 	[1:0]	ALUSrc2_select_o
);

assign ALUSrc1_select_o    =   (EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS1addr_i))? 2'b10 : (MEM_WB_RegWrite && (MEM_WB_RDaddr_i != 5'b0) && !(EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS1addr_i)) && (MEM_WB_RDaddr_i == ID_EX_RS1addr_i))? 2'b01 : 2'b00;

assign ALUSrc2_select_o    =   (EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS2addr_i))? 2'b10 : (MEM_WB_RegWrite && (MEM_WB_RDaddr_i != 5'b0) && !(EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS2addr_i)) && (MEM_WB_RDaddr_i == ID_EX_RS2addr_i))? 2'b01 : 2'b00;

endmodule
