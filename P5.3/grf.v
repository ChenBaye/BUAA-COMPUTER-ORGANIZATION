`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:19 11/21/2016 
// Design Name: 
// Module Name:    grf 
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

module grf(
    input clk,
    input reset,
    input [4:0] RA1,
    input [4:0] RA2,
    input RegWrite,
	 input [4:0] Waddr,
    input [31:0] WData,
    output [31:0] RData1,
    output [31:0] RData2
    );
	reg[31:0] _REG[31:0];
	integer i;
	
	initial begin
	 for(i=0;i<32;i=i+1) begin
		_REG[i]<=32'b0;
		end
	 end
	 
	 assign RData1=(RA1==5'b0)?32'b0:(Waddr==RA1 && RegWrite)?WData:_REG[RA1];
	 assign RData2=(RA2==5'b0)?32'b0:(Waddr==RA2 && RegWrite)?WData:_REG[RA2];
	 
	 always @(posedge clk) begin
		if(reset) begin
			for(i=0;i<32;i=i+1) begin
				_REG[i]<=32'b0;
			end
		end
		else if(RegWrite==1 && Waddr!=5'b0) begin
			_REG[Waddr]<=WData;
			$display("$%d <= %h",Waddr,WData);
		end
	 end
endmodule
