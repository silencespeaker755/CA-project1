# Working stage
1. Support basic operation i.e. add, mul, or, and, sub, lw, sw and beq
2. Pipeline Registers between stages
3. Implement Forwarding Unit
4. Stall one cycle for data dependency caused by lw
5. Implement Hazard Detection Unit for control hazard

# Finished work
1. Implement basic modules, i.e. Adder.v, ALU.v, ...
2. Connect wire in CPU.v
3. Support basic command without pipeline
4. Connect wire between stage and pipeline register in CPU.v 
5. Support basic command with pipeline(verified)

# TODO List
1. Implement Forward unit
2. Stall process when load causing data hazard
2. Move Shift and Adder2 from EX stage to ID stage, which is the pre-requisite of hazard detection
3. Implement Hazard\_Detectioin

HW's Q&A
https://cool.ntu.edu.tw/courses/340/assignments/4349
