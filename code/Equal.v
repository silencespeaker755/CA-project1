module Equal(
	data1_i,
	data2_i,
	Zero_o
);

// Ports
input   	[31:0]  data1_i;
input   	[31:0]  data2_i;
output 				Zero_o;

assign Zero_o   =   (data1_i == data2_i)?   1 : 0;

endmodule
