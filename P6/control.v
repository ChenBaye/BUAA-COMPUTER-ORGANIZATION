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
input bgez_out,
input bgtz_out,
input bltz_out,
input blez_out,
output [1:0] PCOP,
output [1:0] RegDst,
output ExtOP,
output RegWrite,
output [1:0] RegWData,
output ALUSrc,
output [3:0] ALUOP,
output [1:0] start,
output [1:0] multdivOP,
output HIWrite,
output LOWrite,
output HILOOP,
output Select,
output MemWrite,
output [1:0] DMOP, 
output [2:0] expandOP
    );
wire [5:0] OP=instr[31:26];
wire [5:0] FUNC=instr[5:0];
wire add,addi,addiu,addu,sub,subu,ori,lui,j,jal,jr,jalr,bne,beq,bgez,bgtz,bltz,blez,lb,lbu,lh,lhu,lw,sb,sh,sw,sll,srl,AND,OR,XOR,NOR,nop;
wire sra,sllv,srlv,srav,slt,sltu,andi,xori,slti,sltiu,mult,multu,div,divu,mthi,mtlo,mfhi,mflo;

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
assign lb  =(OP==6'b100000)?1:0;
assign lbu =(OP==6'b100100)?1:0;
assign lh  =(OP==6'b100001)?1:0;
assign lhu =(OP==6'b100101)?1:0;

assign sb  =(OP==6'b101000)?1:0;
assign sh  =(OP==6'b101001)?1:0;
assign sw  =(OP==6'b101011)?1:0;

assign bgez=(OP==6'b000001 && instr[20:16]==5'b00001)?1:0;
assign bgtz=(OP==6'b000111)?1:0;
assign bltz=(OP==6'b000001 && instr[20:16]==5'b00000)?1:0;
assign blez=(OP==6'b000110)?1:0;
assign bne =(OP==6'b000101)?1:0;
assign beq =(OP==6'b000100)?1:0;
assign jal =(OP==6'b000011)?1:0;
assign jr  =(OP==6'b000000 && FUNC==6'b001000)?1:0;
assign sll =(OP==6'b000000 && FUNC==6'b000000)?1:0;
assign srl =(OP==6'b000000 && FUNC==6'b000010)?1:0;

assign sra =(OP==6'b000000 && FUNC==6'b000011)?1:0;
assign sllv=(OP==6'b000000 && FUNC==6'b000100)?1:0;
assign srlv=(OP==6'b000000 && FUNC==6'b000110)?1:0;
assign srav=(OP==6'b000000 && FUNC==6'b000111)?1:0;
assign NOR =(OP==6'b000000 && FUNC==6'b100111)?1:0;
assign slt =(OP==6'b000000 && FUNC==6'b101010)?1:0;
assign sltu=(OP==6'b000000 && FUNC==6'b101011)?1:0;

assign andi=(OP==6'b001100)?1:0;
assign xori=(OP==6'b001110)?1:0;
assign slti=(OP==6'b001010)?1:0;
assign sltiu=(OP==6'b001011)?1:0;
assign jalr =(OP==6'b000000 && FUNC==6'b001001)?1:0;

assign mult =(OP==6'b000000 && FUNC==6'b011000);
assign multu=(OP==6'b000000 && FUNC==6'b011001);
assign div  =(OP==6'b000000 && FUNC==6'b011010);
assign divu =(OP==6'b000000 && FUNC==6'b011011);

assign mthi=(OP==6'b000000 && FUNC==6'b010001);
assign mtlo=(OP==6'b000000 && FUNC==6'b010011);

assign mfhi=(OP==6'b000000 && FUNC==6'b010000);
assign mflo=(OP==6'b000000 && FUNC==6'b010010);

assign RegDst={jal,sltiu || slti || xori || andi || addi || addiu || ori || lui || lb || lbu || lh || lhu || lw};//00-rd,01-rt,10-31
assign PCOP={jr || jalr,j || (beq && equal)|| (bne && !equal) || (bgez && bgez_out) || (bgtz && bgtz_out) || (bltz && bltz_out) || (blez && blez_out) || jal};
//00-pc+4   01-(beq,bne,bgez,blez,bltz,bgtz,jal,j)NPC   10-jr£¬jalr
assign ExtOP=sltiu || slti || addi || addiu || lb || lbu || lh || lhu || lw || sb || sh || sw || beq || bne || bgez || bgtz || blez || bltz;
assign RegWrite=mfhi || mflo || add || xori || andi || addiu || addi || addu || sub || subu || ori || lui || lb || lbu || lh || lhu || lw || jal || jalr || sra|| sllv || srlv || srav || slt || slti || sltu || sltiu || sll || srl || AND || OR || XOR || NOR;
assign RegWData={jal || jalr,lb || lbu || lh || lhu || lw};
//00-ALU(add,addi,addiu,addu,sub,subu,sra,sllv,srlv,srav,NOR,slt,sll,srl,AND,OR,lui,ori),01-DM Data,10-PC4_W+4

assign ALUSrc=sltiu || slti || xori || andi || addi || addiu || ori || lui || lb || lbu || lh || lhu || lw || sh || sb || sw;
assign ALUOP={{NOR || sra || sllv || srlv || srav || slt || slti || sltu || sltiu},{sltiu || sltu || slt || slti || srav || XOR || xori || sll || srl || AND || andi},{sltiu || sltu || srlv || sllv || XOR || xori || OR || ori || lui || AND || andi},{XOR || xori || lui || sub || subu || srl || sra || srlv || slt || slti}};
//0000-+,0001--,0010-||,0011-lui,0100-sll,0101-srl,0110-AND,0111-XOR,1000-NOR,1001-sra,1010-sllv,1011-srlv,1100-srav,1101-slt,1110-sltu;
assign start={div || divu,mult || multu};//div,divu-10;mult,multu-01
assign multdivOP={div || divu,multu || divu};//00-mult,01-multu,10-div,11-divu
assign HIWrite=mthi;
assign LOWrite=mtlo;
assign HILOOP=mfhi;
assign Select=mfhi || mflo;
assign MemWrite=sw || sb || sh;
assign DMOP={sw,sh};//00-sb,01-sh,10-sw
assign expandOP={lhu,lbu || lh,lb||lh};//000-lw,001-lb,010-lbu,011-lh,100-lhu
endmodule
