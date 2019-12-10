# CA-project1     Report
## Teammate
    B06902051    呂侑承
    B06902035    王靖傑
    B06902019    洪佳生
# Main steps
1. Set up basic Single Cycle CPU support basic commands.

2. Based on the original Single Cycle CPU version, implement pipeline registers, i.e. IF\ID.v, ID\_EX.v, EX\_MEM.v and MEM\_WB.v without handling hazard caused by pipeline.

3. Add Forwarding.v and HazardDection.v to handle data hazard and control hazard.

# Work division
*   Step 1: 50% done by 呂侑承, while the other 50% done by 洪佳生

*   Step 2: 40% done by 呂侑承, 30% done by 洪佳生, while the other 30% done by 王靖傑 

*   Step 3: 20% done by 呂侑承, 40% done by 洪佳生, while the other 40% done by 王靖傑

# Program usage
*   Compile command: $ make

*   Execute compiled file: $ ./CPU.out

# Implementation of CPU.v
Declare input and output ports of each modules and connect their ports in CPU.v

*    Instruction Fetch

        Including PC.v、Adder.v、MUX32、Instruction_Memory
            
        Load the instruction from instruction memory according to the value of current PC.

*    Instruction Decode
    
        Including HazardDetection.v、Registers.v、Equal.v、Imm_Gen.v、Shift.v、Adder.v、Control.v、MUX7.v
        
        Generate several control signals from the instruction and load the registers' value according to the addresses in the instruction. 

*    Execution
        
        Including Forwarding.v、MUX32_forwarding.v、MUX32.v、ALU_Control.v、ALU.v
        
        According to the result of Forwarding,MUX32_forwarding will which source of data been uesd in ALU.

*    Data Memory
        
        Including Data_Memory.v
        
        According to the control signals,Whether the ALU result will be stored into memory and whether data will be loaded from the memory will be decided and implemented.

*    Write Back
        
        Including MUX32.v
        
        According to the control signals,the write back data will be from data memory or from ALU result.

# Change of testbench.v
* Uncomment lines including Reset:

    Pass Reset to rst_i of CPU.v to solve some problems(mention later).

* Output a debug.vcd file

    Insert two line of code to generate debug.vcd file.

# Implementation of each module
* PC: 

    Program counter, a register which stores the current position of instruction memory.

* Adder: 

     Add the two input value and then output it.

* MUX32: 

    32-bit multiplexer.

* Instruction\_Memory: 

    A memory space to store instructions.

* IF\_ID: 

    We have two registers in it, storing current PC and instruction. If IF_IDWrite_i == 0, we don't change registers' values. If IF_IDflush_i == 1, we flush the registers' values.

* HazardDetection: 

    When the instruction in EX stage is lw, and the RD address is equal to either RS1 or RS2 in ID stage, we set stall_o = 1, PCWrite_o = 0, IF_IDWrite_o = 0 and IDflush_o = 1 to stall the commands in IF_ID pipeline register and insert a bubble command into ID stage.
    When the instruction in ID stage is beq and RS1_data == RS2_data, we set IF_IDflush_o = 1 to flush the command in IF_ID pipeline register since that command don't have to execute.

* Registers: 

    32-bit registers used to store data.

* Equal: 

    It is used to determine whether RS1 is qual to RS2, when instruction == beq.

* Imm\_Gen: 

    Convert the instruction into immediate value according to each instruction formats. 

* Control: 

    Output each control signals according to the control table of each instruction.

* MUX7: 

    When hazard is detected, we flush all the control signals to generate a nop(no operation).

* ID\_EX: 

    The pipeline registers to store necessary data used in EX, MEM, WB stages.

* Forwarding: 

    We have two kinds of forwarding, i.e. EX-forwarding and MEM-forwarding. We compare the RD with RS1 or RS2 to find out which type of forwarding appears, and send the control signal to MUX32_forwarding.

* MUX32\_forwarding: 

    The input contains the original RS1 or RS2, and the result from MEM stage and WB stage. We determine the output according to the type of forwaing.

* ALU\_Control: 

    The signal to determine which ALU is performed.

* ALU: 

    Arithmetic Logic Unit

* EX\_MEM: 

    Store the necessary data for MEM and WB stage.

* Data\_Memory: 

    Write ALU result into Data memory or load Data memory into register.

* MEM\_WB: 

    Transmit the signals from Data Memory stage to Write Back stage.

* Note:

    In all the pipeline registers, IF_ID, ID_EX, EX_MEM and MEM_WB, we use rst_i to determine the time to get the input value from input port in "first cycle". By doing so, we could avoid the registers in pipeline registers from being polluted by the undetermined value x\(z\) of wires during first cycle.

# Encountered Problems
In implemeting the basic CPU without pipelining,we encoutered a problem: When running arithmetic commands with rd and rs1\(2\) pointing to the same register such as "addi x7, x7, 6",the ALU causes some problem causing the program shut down before going to the next cycle. It turns out that the Registers.v file provided in project is customized for pipelined CPU which doesn't work well with our first version code.

After adding pipeline register into CPU, we discovered that even if we initialize the pipeline register in testbench.v, after first cycle the value of some registers and wire are still x or z. We solved this problem by continuing initializing the pipeline registers until rst\_i is set to 1. By doing so, the registers in pipeline wouldn't be poluted by the value x in wires when the program just started. 
