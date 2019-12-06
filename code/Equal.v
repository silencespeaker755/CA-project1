module Equal(
	RS1_i,
	RS2_i,
	Zero_o
);

// Ports
input   [31:0]  RS1_i;
input   [31:0]  RS2_i;
output 			Zero_o;

assign Zero_o = (RS1_i == RS2_i) ? 1:0;