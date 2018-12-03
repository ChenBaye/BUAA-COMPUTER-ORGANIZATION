`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:07 11/21/2016 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] ext_in,
    input EXTOP,
    output [31:0] ext_out
    );
assign ext_out=
(EXTOP==1'b0)?{{16{1'b0}},ext_in}:
(EXTOP==1'b1)?{{16{ext_in[15]}},ext_in}:32'b0;

endmodule