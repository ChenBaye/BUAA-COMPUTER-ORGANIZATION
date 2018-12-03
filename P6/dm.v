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
	input [3:0] be_out,
	input [1:0] DMOP,
    output [31:0] dout
    );
	 reg [31:0] _DM[2047:0];
	 integer i;
	
	 initial begin
	 for(i=0;i<2048;i=i+1) begin
		_DM[i]<=32'b0;
		end
	 end
	 
	 assign dout=_DM[addr[12:2]]; //11bit address
	 
always @(posedge clk) begin
	if(reset) begin
		for(i=0;i<2048;i=i+1) begin
		_DM[i]<=32'b0;
		end
	end
	else if(MemWrite) begin
			if(DMOP==2'b00) begin//sb
				$display("*%h <= %h", addr, din[7:0]);
				if(be_out[0]==1'b1) begin
					_DM[addr[12:2]][7:0]<=din[7:0];
				end
				if(be_out[1]==1'b1) begin
					_DM[addr[12:2]][15:8]<=din[7:0];
				end
				if(be_out[2]==1'b1) begin
					_DM[addr[12:2]][23:16]<=din[7:0];
				end
				if(be_out[3]==1'b1) begin
					_DM[addr[12:2]][31:24]<=din[7:0];
				end
			end
			if(DMOP==2'b01) begin//sh
				$display("*%h <= %h", addr, din[15:0]);
				if(be_out==4'b0011) begin
					_DM[addr[12:2]][15:0]<=din[15:0];
				end
				if(be_out==4'b1100) begin
					_DM[addr[12:2]][31:16]<=din[15:0];
				end
			end
			if(DMOP==2'b10) begin//sw
				$display("*%h <= %h", addr, din);
				_DM[addr[12:2]]<=din;
			end
	end
end
endmodule