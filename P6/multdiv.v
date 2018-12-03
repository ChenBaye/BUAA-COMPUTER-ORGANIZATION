`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:50:28 12/13/2016 
// Design Name: 
// Module Name:    multdiv 
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
module multdiv(
input clk,
input reset,
input [1:0] start,
input [1:0] multdivOP,
input [31:0] multdiv_A,
input [31:0] multdiv_B,
input HIWrite,
input LOWrite,
output reg busy,
output reg [31:0] HI,
output reg [31:0] LO
    );
reg [3:0] counter;
reg [31:0] HI_result;
reg [31:0] LO_result;


initial begin
	busy=1'b0;
	HI=32'b0;
	LO=32'b0;
	counter=4'd9;
	HI_result=32'b0;
	LO_result=32'b0;
end

always @(posedge clk) begin
	if(reset) begin
		busy=1'b0;
		HI=32'b0;
		LO=32'b0;
		counter=4'd9;
		HI_result=32'b0;
		LO_result=32'b0;
	end
	else begin
		if(HIWrite) begin
			HI<=multdiv_A;
		end
		if(LOWrite) begin
			LO<=multdiv_A;
		end
		if(multdivOP==2'b00 && start==2'b01) begin
			{HI_result,LO_result}<=$signed(multdiv_A)*$signed(multdiv_B);
			busy<=1'b1;
			counter<=4'd4;
		end
		if(multdivOP==2'b01 && start==2'b01) begin
			{HI_result,LO_result}<=(multdiv_A)*(multdiv_B);
			busy<=1'b1;
			counter<=4'd4;
		end
		if(multdivOP==2'b10 && start==2'b10 && multdiv_B!=32'b0) begin
			HI_result<=$signed(multdiv_A) % $signed(multdiv_B);
			LO_result<=$signed(multdiv_A) / $signed(multdiv_B);
			busy<=1'b1;
			counter<=4'd9;
		end
		if(multdivOP==2'b11 && start==2'b10 && multdiv_B!=32'b0) begin
			HI_result<=(multdiv_A) % (multdiv_B);
			LO_result<=(multdiv_A) / (multdiv_B);
			busy<=1'b1;
			counter<=4'd9;
		end
		if(busy==1'b1) begin
			if(counter==1'b0) begin
				HI<=HI_result;
				LO<=LO_result;
				busy<=1'b0;
			end
			else begin
				counter<=counter-1;
			end
		end	
	end
end
endmodule
