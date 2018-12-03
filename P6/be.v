`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:26 12/11/2016 
// Design Name: 
// Module Name:    be 
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
module be(
input [1:0] addr1_0,
input [1:0] DMOP,//00-sb,01-sh,10-sw
output [3:0] be_out
    );
assign be_out=
(DMOP==2'b00 && addr1_0==2'b00)?4'b0001:
(DMOP==2'b00 && addr1_0==2'b01)?4'b0010:
(DMOP==2'b00 && addr1_0==2'b10)?4'b0100:
(DMOP==2'b00 && addr1_0==2'b11)?4'b1000:
(DMOP==2'b01 && addr1_0==2'b00)?4'b0011:
(DMOP==2'b01 && addr1_0==2'b10)?4'b1100:
(DMOP==2'b10 && addr1_0==2'b00)?4'b1111:
4'b0000;

endmodule
