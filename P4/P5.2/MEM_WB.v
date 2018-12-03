`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:06:33 11/22/2016 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
input clk,
input reset,
input [31:0] IR_M,
input [31:0] PC4_M,
input [31:0] ALUC_M,
input [31:0] DM_Data,
output [31:0] IR_W,
output [31:0] PC4_W,
output [31:0] ALUC_W,
output [31:0] DM_W
    );
reg [31:0] instr;
reg [31:0] PC4;
reg [31:0] ALUC;
reg [31:0] DM;

assign IR_W=instr;
assign PC4_W=PC4;
assign ALUC_W=ALUC;
assign DM_W=DM;
initial begin
	instr<=32'b0;
	PC4<=32'b0;
	ALUC<=32'b0;
	DM<=32'b0;
end
always @(posedge clk) begin
	if(reset) begin
		instr<=32'b0;
		PC4<=32'b0;
		ALUC<=32'b0;
		DM<=32'b0;
	end
	else begin
		instr<=IR_M;
		PC4<=PC4_M;
		ALUC<=ALUC_M;
		DM<=DM_Data;
	end
end
endmodule
