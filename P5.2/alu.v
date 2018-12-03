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
    output [31:0] ALU_C,
	 output equal
    );
assign ALU_C=
(ALUOP==4'b0000)?(ALU_A+ALU_B):
(ALUOP==4'b0001)?(ALU_A-ALU_B):
(ALUOP==4'b0010)?(ALU_A|ALU_B):
(ALUOP==4'b0011)?{{ALU_B[15:0]},{16{1'b0}}}:32'b0;//lui

assign equal=(ALU_A==ALU_B)?1:0;
endmodule
