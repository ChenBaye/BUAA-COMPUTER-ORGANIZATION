`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:37 11/21/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [3:0] ALUOP,
    input [31:0] ALU_A,
    input [31:0] ALU_B,
	input [4:0] s,
    output [31:0] ALU_C,
	 output equal
    );
assign ALU_C=
(ALUOP==4'b0000)?(ALU_A+ALU_B):
(ALUOP==4'b0001)?(ALU_A-ALU_B):
(ALUOP==4'b0010)?(ALU_A|ALU_B):
(ALUOP==4'b0011)?{{ALU_B[15:0]},{16{1'b0}}}://lui
(ALUOP==4'b0100)?(ALU_B<<s)://sll
(ALUOP==4'b0101)?(ALU_B>>s)://srl
(ALUOP==4'b0110)?(ALU_A&ALU_B)://AND
(ALUOP==4'b0111)?(ALU_A^ALU_B)://XOR
(ALUOP==4'b1000)?~(ALU_A|ALU_B)://NOR
(ALUOP==4'b1001)?{{32{ALU_B[31]}},ALU_B}>>s://sra
(ALUOP==4'b1010)?(ALU_B<<ALU_A[4:0])://sllv
(ALUOP==4'b1011)?(ALU_B>>ALU_A[4:0])://srlv
(ALUOP==4'b1100)?{{32{ALU_B[31]}},ALU_B}>>ALU_A[4:0]://srav
(ALUOP==4'b1101)?($signed(ALU_A)<$signed(ALU_B)?32'b1:32'b0)://slt
(ALUOP==4'b1110)?(ALU_A<ALU_B?32'b1:32'b0):32'b0;//sltu

assign equal=(ALU_A==ALU_B)?1:0;
endmodule
