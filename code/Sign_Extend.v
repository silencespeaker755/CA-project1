// Sign extend the immediate and pass it to Shifter.v
module Sign_Extend(
    data_i,
    data_o
);

// Ports
input   [31:0]  data_i;
output  [31:0]  data_o;

// Wires and Registers
wire 	[6:0]	Op;
wire 	[11:0]	imm;
// Assignment
assign 	Op = data_i[6:0];
assign 	imm = (
	(Op == `R_TYPE) ? 12'Hx :
	(Op == `I_TYPE) ? data_i[31:20] :
	(Op == `LOAD_TYPE) ? data_i[31:20] :
	(Op == `STORE_TYPE) ? {data_i[31:25], data_i[11:7]} :
	(Op == `BRANCH_TYPE) ? {data_i[31], data_i[7], data_i[30:25], data_i[11:8]} :
	12'Hx
);
assign 	data_o = {{20{imm[11]}}, imm};

endmodule