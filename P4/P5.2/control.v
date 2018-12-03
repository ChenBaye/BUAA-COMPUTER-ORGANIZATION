`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:53 11/21/2016 
// Design Name: 
// Module Name:    control 
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
module control(
input [31:0] instr,
input equal,
output [1:0] PCOP,
output [1:0] RegDst,
output ExtOP,
output RegWrite,
output [1:0] RegWData,
output ALUSrc,
output [3:0] ALUOP,
output MemWrite
    );
wire [5:0] OP=instr[31:26];
wire [5:0] FUNC=instr[5:0];
wire addu,subu,ori,lui,j,jal,jr,beq,lw,sw,nop;

assign addu=(OP==6'b000000 && FUNC==6'b100001)?1:0;
assign subu=(OP==6'b000000 && FUNC==6'b100011)?1:0;
assign ori =(OP==6'b001101)?1:0;
assign lui =(OP==6'b001111)?1:0;
assign j   =(OP==6'b000010)?1:0;
assign lw  =(OP==6'b100011)?1:0;
assign sw  =(OP==6'b101011)?1:0;
assign beq =(OP==6'b000100)?1:0;
assign jal =(OP==6'b000011)?1:0;
assign jr  =(OP==6'b000000 && FUNC==6'b001000)?1:0;

assign RegDst={jal,ori || lui || lw};//00-rd,01-rt,10-31
assign PCOP={jr,j || (beq && equal)|| jal};//00-pc+4   01-(beq,jal,j)NPC   10-jr
assign ExtOP=lw || sw || beq;
assign RegWrite=addu || subu || ori || lui || lw || jal;
assign RegWData={jal,lw};//00-ALU(addu,subu,lui,ori),01-DM Data,10-PC4_W+4
assign ALUSrc=ori || lui || lw || sw;
assign ALUOP={2'b0,{ori || lui,lui || subu}};//0000-+,0001--,0010-||,0011-lui
assign MemWrite=sw;
endmodule
