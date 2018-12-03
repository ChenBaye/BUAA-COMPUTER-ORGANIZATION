`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:05 11/22/2016 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
input clk,
input reset,
input clear,
input [31:0] IR_D,
input [31:0] RD1,
input [31:0] RD2,
input [31:0] EXT_out,
input [31:0] PC4_D,
output [31:0] IR_E,
output [31:0] RD1_E,
output [31:0] RD2_E,
output [31:0] EXT_E,
output [31:0] PC4_E
    );
reg [31:0] instr;
reg [31:0] rd1;
reg [31:0] rd2;
reg [31:0] EXT;
reg [31:0] PC4;
assign RD1_E=rd1;
assign IR_E=instr;
assign RD2_E=rd2;
assign PC4_E=PC4;
assign EXT_E=EXT;

initial begin
	instr<=32'b0;
	rd1<=32'b0;
	rd2<=32'b0;
	EXT<=32'b0;
	PC4<=32'b0;
end
always @(posedge clk) begin
	if(reset || clear) begin
		instr<=32'b0;
		rd1<=32'b0;
		rd2<=32'b0;
		EXT<=32'b0;
		PC4<=32'b0;
	end
	else begin
		instr<=IR_D;
		rd1<=RD1;
		rd2<=RD2;
		EXT<=EXT_out;
		PC4<=PC4_D;
	end
end
endmodule





