# Support basic command without PIPELINE
CPU_1.out : Adder.v ALU.v ALU_Control.v Branch_Gate.v Control.v \
			CPU.v Data_Memory.v Instruction_Memory.v MUX32.v \
			PC.v Registers.v Imm_Gen.v Shift.v testbench.v
		iverilog -o CPU_1.out CPU.v testbench.v ALU_Control.v Branch_Gate.v \
			Control.v Data_Memory.v Instruction_Memory.v MUX32.v PC.v \
			Registers.v Imm_Gen.v Adder.v Shift.v ALU.v 
# With Pipeline registers but without handling hazard
CPU_2.out : Adder.v ALU.v ALU_Control.v Branch_Gate.v Control.v \
			CPU.v Data_Memory.v Shift.v Instruction_Memory.v MUX32.v \
			PC.v Registers.v Imm_Gen.v testbench.v EX_MEM.v \
			ID_EX.v IF_ID.v MEM_WB.v
		iverilog -o CPU_1.out CPU.v testbench.v ALU_Control.v Branch_Gate.v \
			Control.v Data_Memory.v Shift.v Instruction_Memory.v MUX32.v PC.v \
			Registers.v Imm_Gen.v Adder.v ALU.v IF_ID.v ID_EX.v \
			EX_MEM.v MEM_WB.v
# With Forwarding unit
# With Hazard detection unit
clean :
	rm CPU_1.out CPU_2.out
