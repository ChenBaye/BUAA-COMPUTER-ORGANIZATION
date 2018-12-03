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
input [1:0] start,
input [1:0] multdivOP,
input HIWrite,
input LOWrite,
input HILOOP,
input Select,
input RegWrite,
input MemWrite,
input [1:0] DMOP,
input [2:0] expandOP,
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
output equal_out,
output bgez_out,
output bgtz_out,
output bltz_out,
output blez_out,
output busy
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
wire [3:0] be_out;
wire [31:0] expand_out;

wire [31:0] HI;
wire [31:0] LO;
wire [31:0] muxHILO_out;
wire [31:0] muxHILO_M;
wire [31:0] muxSelect_out;



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
.ALUC_M(muxSelect_out),
.PC4_M(PC4_M),
.WData(WData),
.MF_RS_D_out(MF_RS_D_out)
);

MF_RT_D MF_RT_D(
.MF_RT_D_OP(MF_RT_D_OP),
.RData2(RData2),
.ALUC_M(muxSelect_out),
.PC4_M(PC4_M),
.WData(WData),
.MF_RT_D_out(MF_RT_D_out)
);



compare compare(
.RD1(MF_RS_D_out),
.RD2(MF_RT_D_out),
.equal_out(equal_out),
.bgez_out(bgez_out),
.bgtz_out(bgtz_out),
.bltz_out(bltz_out),
.blez_out(blez_out)
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
.ALUC_M(muxSelect_out),
.PC4_M(PC4_M),
.WData(WData),
.MF_RS_E_out(MF_RS_E_out)
);

MF_RT_E MF_RT_E(
.MF_RT_E_OP(MF_RT_E_OP),
.RD2_E(RD2_E),
.PC4_M(PC4_M),
.ALUC_M(muxSelect_out),
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
.s(IR_E[10:6]),
.ALU_C(ALU_C),
.equal()
 );
 
multdiv multdiv(
.clk(clk),
.reset(reset),
.start(start),
.multdivOP(multdivOP),
.multdiv_A(MF_RS_E_out),
.multdiv_B(MF_RT_E_out),
.HIWrite(HIWrite),
.LOWrite(LOWrite),
.busy(busy),
.HI(HI),
.LO(LO)
    ); 
 
muxHILO muxHILO(
.HI(HI),
.LO(LO),
.HILOOP(HILOOP),
.muxHILO_out(muxHILO_out)
);

	
EX_MEM EX_MEM(
.clk(clk),
.reset(reset),
.IR_E(IR_E),
.PC4_E(PC4_E),
.RD2_E(MF_RT_E_out),
.ALU_out(ALU_C),
.muxHILO_out(muxHILO_out),
.IR_M(IR_M),
.PC4_M(PC4_M),
.ALUC_M(ALUC_M),
.muxHILO_M(muxHILO_M),
.RD2_M(RD2_M)
 );

muxSelect muxSelect(
.ALUC_M(ALUC_M),
.muxHILO_M(muxHILO_M),
.Select(Select),
.muxSelect_out(muxSelect_out)
);


MF_RT_M MF_RT_M(
.MF_RT_M_OP(MF_RT_M_OP),
.RD2_M(RD2_M),
.WData(WData),
.MF_RT_M_out(MF_RT_M_out)
);

be be(
.addr1_0(ALUC_M[1:0]),
.DMOP(DMOP),//00-sb,01-sh,10-sw
.be_out(be_out)
    );

dm dm(
.clk(clk),
.reset(reset),
.MemWrite(MemWrite),
.addr(ALUC_M),
.din(MF_RT_M_out),
.be_out(be_out),
.DMOP(DMOP),
.dout(DM_Data)
    );

MEM_WB MEM_WB(
.clk(clk),
.reset(reset),
.IR_M(IR_M),
.PC4_M(PC4_M),
.ALUC_M(muxSelect_out),
.DM_Data(DM_Data),
.IR_W(IR_W),
.PC4_W(PC4_W),
.ALUC_W(ALUC_W),
.DM_W(DM_W)
    );

expand expand(
.expandOP(expandOP),//000-lw,001-lb,010-lbu,011-lh,100-lhu
.addr1_0(ALUC_W[1:0]),
.DM_W(DM_W),
.expand_out(expand_out)
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
.DM_W(expand_out),
.WData(WData)
);
endmodule
