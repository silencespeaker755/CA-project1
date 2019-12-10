# Working stage
1. Support basic operation i.e. add, mul, or, and, sub, lw, sw and beq
2. Pipeline Registers between stages
3. Implement Forwarding Unit
4. Stall one cycle for data dependency caused by lw
5. Implement Hazard Detection Unit for control hazard

# Finished work
1. Implement basic modules, i.e. Adder.v, ALU.v, ...
2. Connect wires in CPU.v
3. Support basic command without pipeline
4. Connect wire between stages and pipeline registers in CPU.v 
5. Support basic command with pipeline(verified)
6. Each cycle in the Results of both of instruction.txt and Fibonacci\_instruction.txt are totally the same as TA's version.

# TODO List
0. Fix the naming style such that every wires' name end with \_IF, \_ID, \_EX, \_MEM and \_WB
1. Rename the wire and make a good coding style.
2. Report

HW's Q&A
https://cool.ntu.edu.tw/courses/340/assignments/4349
