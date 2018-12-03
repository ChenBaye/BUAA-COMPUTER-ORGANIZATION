`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:56 11/23/2016 
// Design Name: 
// Module Name:    mux 
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
module muxPCOP(
input [1:0] PCOP,
input [31:0] PC4,
input [31:0] RD1,
input [31:0] NPC,
output reg [31:0] newPC
);
always @(*)begin
	case(PCOP)
		2'b00:newPC<=PC4;
		2'b01:newPC<=NPC;
		2'b10:newPC<=RD1;
		default:newPC<=PC4;
	endcase
end
//00 PC+4,
//01 j or beq or jal
//10 jr
endmodule

module muxRegDst(
input [1:0] RegDst,
input [31:0] IR_W,
output reg [4:0] WAddr
);
always @(*) begin
	case(RegDst)
		2'b00: WAddr<=IR_W[15:11];//rd
		2'b01: WAddr<=IR_W[20:16];//rt
		2'b10: WAddr<=5'd31;
		default: WAddr<=IR_W[15:11];
	endcase
end
//00 rd
//01 rt
//10 31
endmodule

module muxRegWData(
input [31:0] PC4_W,
input [1:0] RegWData,
input [31:0] ALUC_W,
input [31:0] DM_W,
output reg [31:0] WData
);
always@(*)begin
	case(RegWData)
		2'b00:WData<=ALUC_W;
		2'b01:WData<=DM_W;
		2'b10:WData<=PC4_W+4;
		default:WData<=ALUC_W;
	endcase
end
//00 ALU_C-->WData
//01 DM_Data-->WData
//10 PC+8-->WData
endmodule

module muxALUSrc(
input ALUSrc,
input [31:0] RD2,
input [31:0] EXT_out,
output reg [31:0] ALU_B
);

always@(*) begin
	case(ALUSrc)
		1'b0:ALU_B<=RD2;
		1'b1:ALU_B<=EXT_out;
		default:ALU_B<=RD2;
	endcase
end
//0 ALU_B=RD2
//1 ALU_B=EXT(imme)
endmodule

module MF_RS_D(
input [1:0] MF_RS_D_OP,
input [31:0] RData1,
input [31:0] ALUC_M,
input [31:0] PC4_M,
input [31:0] WData,
output reg [31:0] MF_RS_D_out
);
always @(*) begin
	case(MF_RS_D_OP)
		2'b00:	MF_RS_D_out<=RData1;
		2'b01:	MF_RS_D_out<=ALUC_M;
		2'b10:	MF_RS_D_out<=PC4_M+4;
		2'b11:	MF_RS_D_out<=WData;
	endcase
end
endmodule

module MF_RT_D(
input [1:0] MF_RT_D_OP,
input [31:0] RData2,
input [31:0] ALUC_M,
input [31:0] PC4_M,
input [31:0] WData,
output reg [31:0] MF_RT_D_out
);
always @(*) begin
	case(MF_RT_D_OP)
		2'b00:	MF_RT_D_out<=RData2;
		2'b01:	MF_RT_D_out<=ALUC_M;
		2'b10:	MF_RT_D_out<=PC4_M+4;
		2'b11:	MF_RT_D_out<=WData;
		default:MF_RT_D_out<=RData2;
	endcase
end
endmodule


module MF_RS_E(
input [1:0] MF_RS_E_OP,
input [31:0] RD1_E,
input [31:0] ALUC_M,
input [31:0] PC4_M,
input [31:0] WData,
output reg [31:0] MF_RS_E_out
);
always @(*) begin
	case(MF_RS_E_OP)
	2'b00:	MF_RS_E_out<=RD1_E;
	2'b01:	MF_RS_E_out<=ALUC_M;
	2'b10:	MF_RS_E_out<=PC4_M+4;
	2'b11:	MF_RS_E_out<=WData;
	default:MF_RS_E_out<=RD1_E;
	endcase
end
endmodule




module MF_RT_E(
input [1:0] MF_RT_E_OP,
input [31:0] RD2_E,
input [31:0] PC4_M,
input [31:0] ALUC_M,
input [31:0] WData,
output reg [31:0] MF_RT_E_out
);
always @(*) begin
	case(MF_RT_E_OP)
	2'b00:	MF_RT_E_out<=RD2_E;
	2'b01:	MF_RT_E_out<=ALUC_M;
	2'b10:	MF_RT_E_out<=PC4_M+4;
	2'b11:	MF_RT_E_out<=WData;
	default:MF_RT_E_out<=RD2_E;
	endcase
end
endmodule

module muxHILO(
input [31:0] HI,
input [31:0] LO,
input HILOOP,
output reg [31:0] muxHILO_out
);
always @(*) begin
	case(HILOOP)
	1'b0:	muxHILO_out<=LO;
	1'b1:	muxHILO_out<=HI;
	default:muxHILO_out<=LO;
	endcase
end
endmodule


module muxSelect(
input [31:0] ALUC_M,
input [31:0] muxHILO_M,
input Select,
output reg [31:0] muxSelect_out
);
always @(*) begin
	case(Select)
	1'b0:	muxSelect_out<=ALUC_M;
	1'b1:	muxSelect_out<=muxHILO_M;
	default:muxSelect_out<=ALUC_M;
	endcase
end
endmodule




module MF_RT_M(
input [1:0] MF_RT_M_OP,
input [31:0] RD2_M,
input [31:0] WData,
output reg [31:0] MF_RT_M_out
);
always @(*) begin
	case(MF_RT_M_OP)
		2'b00:	MF_RT_M_out<=RD2_M;
		2'b01:	MF_RT_M_out<=WData;
		default:MF_RT_M_out<=RD2_M;
	endcase
end
endmodule


