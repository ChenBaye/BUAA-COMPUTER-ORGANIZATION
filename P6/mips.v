`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:08 11/24/2016 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(input clk,input reset
    );
wire enable;
wire clear;
wire [1:0] PCOP;
wire EXTOP;
wire ALUSrc;
wire [3:0] ALUOP;
wire [1:0] RegDst;
wire [1:0] RegWData;
wire RegWrite;
wire MemWrite;
wire [1:0] DMOP;
wire [2:0] expandOP;
wire [1:0] MF_RS_E_OP;
wire [1:0] MF_RT_E_OP;
wire [1:0] MF_RS_D_OP;
wire [1:0] MF_RT_D_OP;
wire [1:0] MF_RT_M_OP;

wire [31:0] instr_original;
wire [31:0] instr_D;
wire [31:0] instr_E;
wire [31:0] instr_M;
wire [31:0] instr_W;
wire equal_out;
wire bgez_out;
wire bgtz_out;
wire bltz_out;
wire blez_out;

wire [1:0] start;
wire busy;
wire [1:0] multdivOP;
wire HIWrite;
wire LOWrite;
wire HILOOP;
wire Select;

datapath datapath(
.clk(clk),
.reset(reset),
.enable(enable),
.clear(clear),
.PCOP(PCOP),
.EXTOP(EXTOP),
.RegDst(RegDst),
.RegWData(RegWData),
.ALUSrc(ALUSrc),
.ALUOP(ALUOP),
.start(start),
.multdivOP(multdivOP),
.HIWrite(HIWrite),
.LOWrite(LOWrite),
.HILOOP(HILOOP),
.Select(Select),
.RegWrite(RegWrite),
.MemWrite(MemWrite),
.DMOP(DMOP),
.expandOP(expandOP),
.MF_RS_D_OP(MF_RS_D_OP),
.MF_RT_D_OP(MF_RT_D_OP),
.MF_RS_E_OP(MF_RS_E_OP),
.MF_RT_E_OP(MF_RT_E_OP),
.MF_RT_M_OP(MF_RT_M_OP),
.instr_original(instr_original),
.instr_D(instr_D),
.instr_E(instr_E),
.instr_M(instr_M),
.instr_W(instr_W),
.equal_out(equal_out),
.bgez_out(bgez_out),
.bgtz_out(bgtz_out),
.bltz_out(bltz_out),
.blez_out(blez_out),
.busy(busy)
    );
	
control control_D(
.instr(instr_D),
.equal(equal_out),
.bgez_out(bgez_out),
.bgtz_out(bgtz_out),
.bltz_out(bltz_out),
.blez_out(blez_out),
.PCOP(PCOP),
.ExtOP(EXTOP)
    );

control control_E(
.instr(instr_E),
.ALUSrc(ALUSrc),
.ALUOP(ALUOP),
.start(start),
.multdivOP(multdivOP),
.HIWrite(HIWrite),
.LOWrite(LOWrite),
.HILOOP(HILOOP)
    );

control control_M(
.instr(instr_M),
.Select(Select),
.MemWrite(MemWrite),
.DMOP(DMOP)
    );

control control_W(
.instr(instr_W),
.RegDst(RegDst),
.RegWrite(RegWrite),
.RegWData(RegWData),
.expandOP(expandOP)
    );
	
hazard hazard(
.IR_D(instr_D),
.IR_E(instr_E),
.IR_M(instr_M),
.IR_W(instr_W),
.start(start),
.busy(busy),
.MF_RS_E_OP(MF_RS_E_OP),
.MF_RT_E_OP(MF_RT_E_OP),
.MF_RS_D_OP(MF_RS_D_OP),
.MF_RT_D_OP(MF_RT_D_OP),
.MF_RT_M_OP(MF_RT_M_OP),
.enable(enable),
.clear(clear)
    );
endmodule
