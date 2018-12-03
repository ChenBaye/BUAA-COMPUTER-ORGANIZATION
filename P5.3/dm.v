`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:29:34 11/21/2016 
// Design Name: 
// Module Name:    dm 
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
module dm(
    input clk,
    input reset,
    input MemWrite,
    input [31:0] addr,
    input [31:0] din,
    output [31:0] dout
    );
	 reg [31:0] _DM[1023:0];
	 integer i;
	
	 initial begin
	 for(i=0;i<1024;i=i+1) begin
		_DM[i]<=32'b0;
		end
	 end
	 
	 assign dout=_DM[addr[11:2]]; //10bit addreaa
	 
always @(posedge clk) begin
	if(reset) begin
		for(i=0;i<1024;i=i+1) begin
		_DM[i]<=32'b0;
		end
	end
	else if(MemWrite) begin
		_DM[addr[11:2]]<=din;
		$display("*%h <= %h", addr, din);
	end
end
endmodule