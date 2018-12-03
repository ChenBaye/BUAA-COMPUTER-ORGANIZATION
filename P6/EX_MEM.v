`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:44 11/22/2016 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
input clk,
input reset,
input [31:0] IR_E,
input [31:0] PC4_E,
input [31:0] RD2_E,
input [31:0] ALU_out,
input [31:0] muxHILO_out,
output [31:0] IR_M,
output [31:0] PC4_M,
output [31:0] ALUC_M,
output [31:0] muxHILO_M,
output [31:0] RD2_M
    );
reg [31:0] instr;
reg [31:0] PC4;
reg [31:0] rd2;
reg [31:0] ALUC;
reg [31:0] HILO;

assign IR_M=instr;
assign PC4_M=PC4;
assign ALUC_M=ALUC;
assign RD2_M=rd2;
assign muxHILO_M=HILO;

initial begin
	instr<=32'b0;
	PC4<=32'b0;
	rd2<=32'b0;
	ALUC<=32'b0;
	HILO<=32'b0;
end
always@(posedge clk) begin
	if(reset) begin
		instr<=32'b0;
		PC4<=32'b0;
		rd2<=32'b0;
		ALUC<=32'b0;
		HILO<=32'b0;
	end
	else begin
		instr<=IR_E;
		PC4<=PC4_E;
		rd2<=RD2_E;
		ALUC<=ALU_out;
		HILO<=muxHILO_out;
	end
end
endmodule
