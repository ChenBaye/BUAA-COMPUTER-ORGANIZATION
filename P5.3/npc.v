`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:57 11/23/2016 
// Design Name: 
// Module Name:    npc 
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
module npc(input [31:0] IR_D,input [31:0] PC4_D,input [31:0] EXT_out,output [31:0] NPC
    );
wire [5:0] OP=IR_D[31:26];
wire [5:0] FUNC=IR_D[5:0];
wire j,beq,jal,bne;
wire [31:0] j_PC={{PC4_D[31:28]},{{IR_D[25:0]},2'b00}};
wire [31:0] beq_PC={{EXT_out[29:0]},2'b00}+PC4_D;
assign j   =(OP==6'b000010)?1:0;
assign beq =(OP==6'b000100)?1:0;
assign jal =(OP==6'b000011)?1:0;
assign bne =(OP==6'b000101)?1:0;

assign NPC=(j==1 || jal==1)?j_PC:(beq==1 || bne==1)?beq_PC:PC4_D;
endmodule
