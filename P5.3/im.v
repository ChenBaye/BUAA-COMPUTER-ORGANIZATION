`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:18 11/21/2016 
// Design Name: 
// Module Name:    im 
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
module im(
    input [31:0] address,
    output [31:0] instr
    );
	wire [31:0] addr;
	assign addr=address-32'h00003000;
	reg [31:0] _IM[1023:0];
	assign instr=_IM[addr[11:2]];
	initial begin
		$readmemh("code.txt",_IM);
	 end
endmodule


