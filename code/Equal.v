module Equal(
	RS1_i,
	RS2_i,
	Zero_o
);

// Ports
input   	[31:0]  RS1_i;
input   	[31:0]  RS2_i;
output 				Zero_o;

reg reg_Zero;

assign Zero_o = reg_Zero;

initial begin
	reg_Zero = 1'b0;
end

always@(*) begin
	reg_Zero = (RS1_i == RS2_i) ? 1:0;
end

endmodule