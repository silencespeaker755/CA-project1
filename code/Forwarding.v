module Forwarding(
	input 			EX_MEM_RegWrite,
    input 			MEM_WB_RegWrite,
    input 	[4:0]	ID_EX_RS1addr_i,
    input 	[4:0]	ID_EX_RS2addr_i,
    input 	[4:0]	EX_MEM_RDaddr_i,
    input 	[4:0]	MEM_WB_RDaddr_i,
    output 	[1:0]	ALU_src1_select_o,
    output 	[1:0]	ALU_src2_select_o
);

reg [1:0]	ALU_select1;
reg [1:0]	ALU_select2;

assign ALU_src1_select_o = ALU_select1;
assign ALU_src2_select_o = ALU_select2;

always@(*) begin
	ALU_select1 = 2'b00;
	ALU_select2 = 2'b00;
	// EX hazard
	if(EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS1addr_i))
		ALU_select1 = 2'b10;
	if(EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS2addr_i))
		ALU_select2 = 2'b10;
	// MEM hazard
	if(MEM_WB_RegWrite && (MEM_WB_RDaddr_i != 5'b0) && 
		!(EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS1addr_i)) &&
		(MEM_WB_RDaddr_i == ID_EX_RS1addr_i))
		ALU_select1 = 2'b01;
	if(MEM_WB_RegWrite && (MEM_WB_RDaddr_i != 5'b0) && 
		!(EX_MEM_RegWrite && (EX_MEM_RDaddr_i != 5'b0) && (EX_MEM_RDaddr_i == ID_EX_RS2addr_i)) &&
		(MEM_WB_RDaddr_i == ID_EX_RS2addr_i))
		ALU_select2 = 2'b01;
end

