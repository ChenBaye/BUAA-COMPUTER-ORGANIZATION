`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:46:14 11/22/2016 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
input clk,
input reset,
input enable,
input [31:0] IR_IM,
input [31:0] PC4_ADD4,
output [31:0] PC4_D,
output [31:0] IR_D
    );
reg [31:0] instr;
reg [31:0] PC4;

assign IR_D=instr;
assign PC4_D=PC4;

initial begin
	instr<=32'b0;
	PC4<=32'b0;
end
always @(posedge clk) begin
	if(reset) begin
		instr<=32'b0;
		PC4<=32'b0;
	end
	else if(reset==1'b0 && enable==1'b1)begin
		instr<=IR_IM;
		PC4<=PC4_ADD4;
	end
end
endmodule
