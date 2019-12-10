# CA-project1     Report
## Teammate
	B06902051    呂侑承
    B06902035    王靖傑
    B06902019    洪佳生
# Main steps
1. 架設起基礎的Single cycle CPU去確保所有的功能是保證能正常運作的。

2. 基於原本的Single cycle CPU加上pipeline register stage去實行沒有hazard處理的CPU with pipeline。

3. 加上hazard的處理來完善整個CPU的功能。

# Implementation of CPU.v
在CPU中宣告好各個module所需要的input & output連接所需要的wires，並將其以適當的方式連接起來形成具有五個pipeline stage的CPU。

*    Instruction Fetch

        包含PC.v、Adder.v、MUX32、Instruction_Memory
            
        Load the instruction from instruction memory according to the value of current PC.

*    Instruction Decode
    
        包含HazardDetection.v、Registers.v、Equal.v、Imm_Gen.v、Shift.v、Adder.v、Control.v、MUX7.v
        
        Genereate several control signals from the instruction and load the registers' value according to the addresses in the instruction. 

*    Execution
        
        包含Forwarding.v、MUX32_forwarding.v、MUX32.v、ALU_Control.v、ALU.v
        
        According to the result of Forwarding,MUX32_forwarding will which source of data been uesd in ALU.

*    Data Memory
        包含Data_Memory.v
        
        According to the control signals,Whether the ALU result will be stored into memory and whether data will be loaded from the memory will be decided and implemented.

*    Write Back
        包含MUX32.v
        
        According to the control signals,the write back data will be from data memory or from ALU result.

# Implementation of each module
PC:

Adder:

MUX32:

Instruction_Memory:

IF_ID:

HazardDetection:

Registers:

Equal:

Imm_Gen:

Control:

MUX7:

ID_EX:

Forwarding:

MUX32_forwarding:

ALU_Control:

ALU:

EX_MEM:

Data_Memory:

MEM_WB: