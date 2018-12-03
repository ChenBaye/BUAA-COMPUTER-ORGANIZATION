`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:41 11/29/2016 
// Design Name: 
// Module Name:    equal 
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
module compare(
input [31:0] RD1,
input [31:0] RD2,
output equal_out
    );
assign equal_out=(RD1==RD2)?1'b1:1'b0;
endmodule
