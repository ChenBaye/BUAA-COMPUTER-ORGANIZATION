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
wire add,addi,addiu,addu,sub,subu,ori,lui,j,jal,jr,bne,beq,lw,sw,sll,srl,AND,OR,XOR,nop;

assign add =(OP==6'b000000 && FUNC==6'b100000)?1:0;
assign addi=(OP==6'b001000)?1:0;
assign addiu=(OP==6'b001001)?1:0;
assign addu=(OP==6'b000000 && FUNC==6'b100001)?1:0;
assign AND =(OP==6'b000000 && FUNC==6'b100100)?1:0;
assign OR  =(OP==6'b000000 && FUNC==6'b100101)?1:0;
assign XOR =(OP==6'b000000 && FUNC==6'b100110)?1:0;

assign sub =(OP==6'b000000 && FUNC==6'b100010)?1:0;
assign subu=(OP==6'b000000 && FUNC==6'b100011)?1:0;
assign ori =(OP==6'b001101)?1:0;
assign lui =(OP==6'b001111)?1:0;
assign j   =(OP==6'b000010)?1:0;
assign lw  =(OP==6'b100011)?1:0;
assign sw  =(OP==6'b101011)?1:0;
assign bne =(OP==6'b000101)?1:0;
assign beq =(OP==6'b000100)?1:0;
assign jal =(OP==6'b000011)?1:0;
assign jr  =(OP==6'b000000 && FUNC==6'b001000)?1:0;
assign sll =(OP==6'b000000 && FUNC==6'b000000)?1:0;
assign srl =(OP==6'b000000 && FUNC==6'b000010)?1:0;

assign RegDst={jal,addi || addiu || ori || lui || lw};//00-rd,01-rt,10-31
assign PCOP={jr,j || (beq && equal)|| (bne && !equal) || jal};//00-pc+4   01-(beq,bne,jal,j)NPC   10-jr
assign ExtOP=addi || addiu || lw || sw || beq || bne;
assign RegWrite=add || addiu || addi || addu || sub || subu || ori || lui || lw || jal || sll || srl || AND || OR || XOR;
assign RegWData={jal,lw};
//00-ALU(add,addi,addiu,addu,sub,subu,sll,srl,AND,OR,lui,ori),01-DM Data,10-PC4_W+4

assign ALUSrc=addi || addiu || ori || lui || lw || sw;
assign ALUOP={1'b0,{XOR || sll || srl || AND},{XOR || OR || ori || lui || AND},{XOR || lui || sub || subu || srl}};
//0000-+,0001--,0010-||,0011-lui,0100-sll,0101-srl,0110-AND,0111-XOR;
assign MemWrite=sw;
endmodule
