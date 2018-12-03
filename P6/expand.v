`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:49 12/11/2016 
// Design Name: 
// Module Name:    expand 
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
module expand(
input [2:0] expandOP,//000-lw,001-lb,010-lbu,011-lh,100-lhu
input [1:0] addr1_0,
input [31:0] DM_W,
output [31:0] expand_out
    );
assign expand_out=
(expandOP==3'b000)?DM_W://lw

(expandOP==3'b001 && addr1_0==2'b00)?{{24{DM_W[7]}},DM_W[7:0]}://lb
(expandOP==3'b001 && addr1_0==2'b01)?{{24{DM_W[15]}},DM_W[15:8]}:
(expandOP==3'b001 && addr1_0==2'b10)?{{24{DM_W[23]}},DM_W[23:16]}:
(expandOP==3'b001 && addr1_0==2'b11)?{{24{DM_W[31]}},DM_W[31:24]}:

(expandOP==3'b010 && addr1_0==2'b00)?{{24{1'b0}},DM_W[7:0]}://lbu
(expandOP==3'b010 && addr1_0==2'b01)?{{24{1'b0}},DM_W[15:8]}:
(expandOP==3'b010 && addr1_0==2'b10)?{{24{1'b0}},DM_W[23:16]}:
(expandOP==3'b010 && addr1_0==2'b11)?{{24{1'b0}},DM_W[31:24]}:

(expandOP==3'b011 && addr1_0==2'b00)?{{16{DM_W[15]}},DM_W[15:0]}://lh
(expandOP==3'b011 && addr1_0==2'b10)?{{16{DM_W[31]}},DM_W[31:16]}:

(expandOP==3'b100 && addr1_0==2'b00)?{{16{1'b0}},DM_W[15:0]}://lhu
(expandOP==3'b100 && addr1_0==2'b10)?{{16{1'b0}},DM_W[31:16]}:
DM_W;

endmodule
