`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:00:53 11/21/2016 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input [31:0] PC_in,
	 input clk,
    input reset,
	input enable,
    output [31:0] PC_out
    );
	 reg [31:0] PC;
assign PC_out=PC;
initial begin
	PC<=32'h00003000;
end
always @(posedge clk) begin
	if (reset) begin
		PC<=32'h00003000;
	end
	else if(reset==1'b0 && enable==1'b1)begin
		PC<=PC_in;
	end
end
endmodule