`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:41 11/29/2016 
// Design Name: 
// Module Name:    compare 
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
output equal_out,
output bgez_out,
output bgtz_out,
output bltz_out,
output blez_out
    );
assign equal_out=(RD1==RD2)?1'b1:1'b0;
assign  bgez_out=$signed(RD1)>=0?1'b1:1'b0;
assign  bgtz_out=$signed(RD1)>0?1'b1:1'b0;
assign  bltz_out=$signed(RD1)<0?1'b1:1'b0;
assign  blez_out=$signed(RD1)<=0?1'b1:1'b0;
endmodule
