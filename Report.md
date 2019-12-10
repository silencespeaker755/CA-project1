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

write ALU result into Data memory or load Data memory into register.

MEM_WB:

Transmit the signals from Data Memory stage to Write Back stage.

# Dilemma
when we wanted to implemet the basic CPU without pipelining,the register.v file which TA gave doesn't work in our code.
During the implementation in the same address of rd and (rs2 or rs1) ,such as "addi x7, x7, 6",the program wouldn't stop so in this step we replace single cycle's register.v into project1's register.v.

when we added pipeline register stage into CPU and implement it,we discovered that if we don't initialize the pipeline register,then there would be some x or z that appear in some wires or registers after cycle 1.We solved this problem by consistently initializing the pipeline registers when rst is 0.

My teamate would like to keep a good coding style so after we finish the whole program and it works,he renames the wire and replace them by modules' outputs.Besides,he deletes the additional registers that may not be necessarily after the change and,in a little part of the code,reconnects the outputs & inputs in different way. To make a long story short(All in all),he did a great job but in the original version it still works good.When I discover that the whole new version of code isn't like what I wrote before,be honestly that I was very furious and a little upset.Maybe I am not suitable for this team because almost everything I did was reset by the other.I know it isn't his fault but still feel anxiety.