`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:51 11/24/2016 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
input clk,
input reset,
input enable,
input clear,
input [1:0] PCOP,
input EXTOP,
input [1:0] RegDst,
input [1:0] RegWData,
input ALUSrc,
input [3:0] ALUOP,
input RegWrite,
input MemWrite,
input [1:0] MF_RS_D_OP,
input [1:0] MF_RT_D_OP,
input [1:0] MF_RS_E_OP,
input [1:0] MF_RT_E_OP,
input [1:0] MF_RT_M_OP,

output [31:0] instr_original,
output [31:0] instr_D,
output [31:0] instr_E,
output [31:0] instr_M,
output [31:0] instr_W,
output equal_out
    );
wire [31:0] IR_D;
wire [31:0] IR_E;
wire [31:0] IR_M;
wire [31:0] IR_W;
wire [31:0] newPC;
wire [31:0] PC_out;
wire [31:0] PC4;
wire [31:0] instr;
wire [31:0] NPC;
wire [31:0] PC4_D;
wire [31:0] EXT_out;
wire [31:0] RData1;
wire [31:0] RData2;
wire [31:0] MF_RS_D_out;
wire [31:0] MF_RT_D_out;



wire [31:0] RD1_E;
wire [31:0] RD2_E;
wire [31:0] EXT_E;
wire [31:0] PC4_E;
wire [31:0] PC4_M;
wire [31:0] ALUC_M;
wire [31:0] RD2_M;
wire [31:0] MF_RS_E_out;
wire [31:0] MF_RT_E_out;
wire [31:0] ALU_B;
wire [31:0] ALU_C;
wire [31:0] MF_RT_M_out;
wire [31:0] DM_Data;
wire [31:0] PC4_W;
wire [31:0] ALUC_W;
wire [31:0] DM_W;
wire [31:0] WData;
wire [4:0] WAddr;
assign instr_original=instr;
assign instr_D=IR_D;
assign instr_E=IR_E;
assign instr_M=IR_M;
assign instr_W=IR_W;


pc pc(
.PC_in(newPC),
.clk(clk),
.reset(reset),
.enable(enable),
.PC_out(PC_out)
    );
	
muxPCOP muxPCOP(
.PCOP(PCOP),
.PC4(PC4),
.RD1(MF_RS_D_out),
.NPC(NPC),
.newPC(newPC)
);

add4 add4(
.PC(PC_out),
.PC4(PC4)
    );
	
im im(
.address(PC_out),
.instr(instr)
    );

IF_ID IF_ID(
.clk(clk),
.reset(reset),
.enable(enable),
.IR_IM(instr),
.PC4_ADD4(PC4),
.PC4_D(PC4_D),
.IR_D(IR_D)
    );	

ext ext(
.ext_in(IR_D[15:0]),
.EXTOP(EXTOP),
.ext_out(EXT_out)
    );
	
grf grf(
.clk(clk),
.reset(reset),
.RA1(IR_D[25:21]),
.RA2(IR_D[20:16]),
.RegWrite(RegWrite),
.Waddr(WAddr),
.WData(WData),
.RData1(RData1),
.RData2(RData2)
    );
	
MF_RS_D MF_RS_D(
.MF_RS_D_OP(MF_RS_D_OP),
.RData1(RData1),
.ALUC_M(ALUC_M),
.PC4_M(PC4_M),
.WData(WData),
.MF_RS_D_out(MF_RS_D_out)
);

MF_RT_D MF_RT_D(
.MF_RT_D_OP(MF_RT_D_OP),
.RData2(RData2),
.ALUC_M(ALUC_M),
.PC4_M(PC4_M),
.WData(WData),
.MF_RT_D_out(MF_RT_D_out)
);



equal equal(
.RD1(MF_RS_D_out),
.RD2(MF_RT_D_out),
.equal_out(equal_out)
);


npc npc(
.IR_D(IR_D),
.PC4_D(PC4_D),
.EXT_out(EXT_out),
.NPC(NPC)
 );

ID_EX ID_EX(
.clk(clk),
.reset(reset),
.clear(clear),
.IR_D(IR_D),
.RD1(MF_RS_D_out),
.RD2(MF_RT_D_out),
.EXT_out(EXT_out),
.PC4_D(PC4_D),
.IR_E(IR_E),
.RD1_E(RD1_E),
.RD2_E(RD2_E),
.EXT_E(EXT_E),
.PC4_E(PC4_E)
 );


MF_RS_E MF_RS_E(
.MF_RS_E_OP(MF_RS_E_OP),
.RD1_E(RD1_E),
.ALUC_M(ALUC_M),
.PC4_M(PC4_M),
.WData(WData),
.MF_RS_E_out(MF_RS_E_out)
);

MF_RT_E MF_RT_E(
.MF_RT_E_OP(MF_RT_E_OP),
.RD2_E(RD2_E),
.PC4_M(PC4_M),
.ALUC_M(ALUC_M),
.WData(WData),
.MF_RT_E_out(MF_RT_E_out)
);

muxALUSrc muxALUSrc(
.ALUSrc(ALUSrc),
.RD2(MF_RT_E_out),
.EXT_out(EXT_E),
.ALU_B(ALU_B)
);

alu alu(
.ALUOP(ALUOP),
.ALU_A(MF_RS_E_out),
.ALU_B(ALU_B),
.ALU_C(ALU_C),
.equal()
 );
	
EX_MEM EX_MEM(
.clk(clk),
.reset(reset),
.IR_E(IR_E),
.PC4_E(PC4_E),
.RD2_E(MF_RT_E_out),
.ALU_out(ALU_C),
.IR_M(IR_M),
.PC4_M(PC4_M),
.ALUC_M(ALUC_M),
.RD2_M(RD2_M)
 );

MF_RT_M MF_RT_M(
.MF_RT_M_OP(MF_RT_M_OP),
.RD2_M(RD2_M),
.WData(WData),
.MF_RT_M_out(MF_RT_M_out)
);

dm dm(
.clk(clk),
.reset(reset),
.MemWrite(MemWrite),
.addr(ALUC_M),
.din(MF_RT_M_out),
.dout(DM_Data)
    );

MEM_WB MEM_WB(
.clk(clk),
.reset(reset),
.IR_M(IR_M),
.PC4_M(PC4_M),
.ALUC_M(ALUC_M),
.DM_Data(DM_Data),
.IR_W(IR_W),
.PC4_W(PC4_W),
.ALUC_W(ALUC_W),
.DM_W(DM_W)
    );
	
muxRegDst muxRegDst(
.RegDst(RegDst),
.IR_W(IR_W),
.WAddr(WAddr)
);

muxRegWData muxRegWData(
.PC4_W(PC4_W),
.RegWData(RegWData),
.ALUC_W(ALUC_W),
.DM_W(DM_W),
.WData(WData)
);
endmodule
