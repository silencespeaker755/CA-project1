module Equal(
	RS1_i,
	RS2_i,
	Zero_o
);

// Ports
input   	[31:0]  RS1_i;
input   	[31:0]  RS2_i;
output 				Zero_o;

<<<<<<< HEAD
reg reg_Zero;

assign Zero_o = reg_Zero;

initial begin
	reg_Zero = 1'b0;
end

always@(*) begin
	reg_Zero = (RS1_i == RS2_i) ? 1:0;
end

endmodule
=======
assign Zero_o = (RS1_i == RS2_i) ? 1:0;
endmodule
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261
