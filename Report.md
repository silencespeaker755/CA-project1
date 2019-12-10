# CA-project1     Report
## Teammate
	呂侑承、王靖傑、洪佳生

1. 架設起基礎的Single cycle CPU去確保所有的功能是保證能正常運作的。

2. 基於原本的Single cycle CPU加上pipeline register stage去實行沒有hazard處理的CPU with pipeline。

3. 加上hazard的處理來完善整個CPU的功能。

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

# Implementation of each module
PC: 沒有改動

Adder: 把兩個input加起來output出去

MUX32: 32位元的MUX
Instruction_Memory: 沒有改動

IF_ID: 存入pc還有instruction，然後加入stall還有flush兩個指令

HazardDetection: 當EX_stage的指令是lw，並且RD等於ID_stage的RS1或RS2，發出hazard_detection

Registers: 沒有改動

Equal: 當指令為beq時用來檢查RS1是否等於RS2

Imm_Gen: 把各種instruction format的immediate值拔出來，並extend成32位元

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
