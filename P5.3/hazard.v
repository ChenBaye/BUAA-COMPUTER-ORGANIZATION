`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:24 11/21/2016 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
input [31:0] IR_D,
input [31:0] IR_E,
input [31:0] IR_M,
input [31:0] IR_W,
output [1:0] MF_RS_E_OP,
output [1:0] MF_RT_E_OP,
output [1:0] MF_RS_D_OP,
output [1:0] MF_RT_D_OP,
output [1:0] MF_RT_M_OP,
output enable,
output clear
    );
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define op 31:26
`define func 5:0
wire addu_D,subu_D,ori_D,lui_D,j_D,jal_D,jr_D,beq_D,sw_D,lw_D,add_D,addi_D,addiu_D,sub_D,bne_D,sll_D,srl_D,and_D,or_D,xor_D;

wire addu_E,subu_E,ori_E,lui_E,j_E,jal_E,jr_E,beq_E,sw_E,lw_E,add_E,addi_E,addiu_E,sub_E,bne_E,sll_E,srl_E,and_E,or_E,xor_E;

wire addu_M,subu_M,ori_M,lui_M,j_M,jal_M,jr_M,beq_M,sw_M,lw_M,add_M,addi_M,addiu_M,sub_M,bne_M,sll_M,srl_M,and_M,or_M,xor_M;

wire addu_W,subu_W,ori_W,lui_W,j_W,jal_W,jr_W,beq_W,sw_W,lw_W,add_W,addi_W,addiu_W,sub_W,bne_W,sll_W,srl_W,and_W,or_W,xor_W;

wire CAL_R_D,CAL_I_D,load_D,store_D,b_D;
wire CAL_R_E,CAL_I_E,load_E,store_E,b_E;
wire CAL_R_M,CAL_I_M,load_M,store_M,b_M;
wire CAL_R_W,CAL_I_W,load_W,store_W,b_W;
wire stop;

assign addu_D=(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100001)?1:0;
assign subu_D=(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100011)?1:0;
assign ori_D =(IR_D[`op]==6'b001101)?1:0;
assign lui_D =(IR_D[`op]==6'b001111)?1:0;
assign j_D   =(IR_D[`op]==6'b000010)?1:0;
assign jal_D =(IR_D[`op]==6'b000011)?1:0;
assign jr_D  =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b001000)?1:0;
assign beq_D =(IR_D[`op]==6'b000100)?1:0;
assign sw_D  =(IR_D[`op]==6'b101011)?1:0;
assign lw_D  =(IR_D[`op]==6'b100011)?1:0;

assign add_D =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100000)?1:0;
assign addi_D=(IR_D[`op]==6'b001000)?1:0;
assign addiu_D=(IR_D[`op]==6'b001001)?1:0;
assign sub_D =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100010)?1:0;
assign sll_D =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b000000)?1:0;
assign srl_D =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b000010)?1:0;
assign and_D =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100100)?1:0;
assign or_D  =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100101)?1:0;
assign xor_D =(IR_D[`op]==6'b000000 && IR_D[`func]==6'b100110)?1:0;
assign bne_D =(IR_D[`op]==6'b000101)?1:0;

assign CAL_R_D=addu_D || subu_D || add_D || sub_D || sll_D || srl_D || and_D || or_D || xor_D;
assign CAL_I_D=ori_D || lui_D || addi_D || addiu_D;
assign store_D=sw_D;
assign load_D =lw_D;
assign b_D    =beq_D || bne_D;

assign addu_E=(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100001)?1:0;
assign subu_E=(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100011)?1:0;
assign ori_E =(IR_E[`op]==6'b001101)?1:0;
assign lui_E =(IR_E[`op]==6'b001111)?1:0;
assign j_E   =(IR_E[`op]==6'b000010)?1:0;
assign jal_E =(IR_E[`op]==6'b000011)?1:0;
assign jr_E  =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b001000)?1:0;
assign beq_E =(IR_E[`op]==6'b000100)?1:0;
assign sw_E  =(IR_E[`op]==6'b101011)?1:0;
assign lw_E  =(IR_E[`op]==6'b100011)?1:0;

assign add_E =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100000)?1:0;
assign addi_E=(IR_E[`op]==6'b001000)?1:0;
assign addiu_E=(IR_E[`op]==6'b001001)?1:0;
assign sub_E =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100010)?1:0;
assign sll_E =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b000000)?1:0;
assign srl_E =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b000010)?1:0;
assign and_E =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100100)?1:0;
assign or_E  =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100101)?1:0;
assign xor_E =(IR_E[`op]==6'b000000 && IR_E[`func]==6'b100110)?1:0;
assign bne_E =(IR_E[`op]==6'b000101)?1:0;

assign CAL_R_E=addu_E || subu_E || add_E || sub_E || sll_E || srl_E || and_E || or_E || xor_E;
assign CAL_I_E=ori_E || lui_E || addi_E || addiu_E;
assign store_E=sw_E;
assign load_E =lw_E;
assign b_E    =beq_E || bne_E;


assign addu_M=(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100001)?1:0;
assign subu_M=(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100011)?1:0;
assign ori_M =(IR_M[`op]==6'b001101)?1:0;
assign lui_M =(IR_M[`op]==6'b001111)?1:0;
assign j_M   =(IR_M[`op]==6'b000010)?1:0;
assign jal_M =(IR_M[`op]==6'b000011)?1:0;
assign jr_M  =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b001000)?1:0;
assign beq_M =(IR_M[`op]==6'b000100)?1:0;
assign sw_M  =(IR_M[`op]==6'b101011)?1:0;
assign lw_M  =(IR_M[`op]==6'b100011)?1:0;

assign add_M =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100000)?1:0;
assign addi_M=(IR_M[`op]==6'b001000)?1:0;
assign addiu_M=(IR_M[`op]==6'b001001)?1:0;
assign sub_M =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100010)?1:0;
assign sll_M =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b000000)?1:0;
assign srl_M =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b000010)?1:0;
assign and_M =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100100)?1:0;
assign or_M  =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100101)?1:0;
assign xor_M =(IR_M[`op]==6'b000000 && IR_M[`func]==6'b100110)?1:0;
assign bne_M =(IR_M[`op]==6'b000101)?1:0;

assign CAL_R_M=addu_M || subu_M || add_M || sub_M || sll_M || srl_M || and_M || or_M || xor_M;
assign CAL_I_M=ori_M || lui_M || addi_M || addiu_M;
assign store_M=sw_M;
assign load_M =lw_M;
assign b_M    =beq_M || bne_M;


assign addu_W=(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100001)?1:0;
assign subu_W=(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100011)?1:0;
assign ori_W =(IR_W[`op]==6'b001101)?1:0;
assign lui_W =(IR_W[`op]==6'b001111)?1:0;
assign j_W   =(IR_W[`op]==6'b000010)?1:0;
assign jal_W =(IR_W[`op]==6'b000011)?1:0;
assign jr_W  =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b001000)?1:0;
assign beq_W =(IR_W[`op]==6'b000100)?1:0;
assign sw_W  =(IR_W[`op]==6'b101011)?1:0;
assign lw_W  =(IR_W[`op]==6'b100011)?1:0;

assign add_W =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100000)?1:0;
assign addi_W=(IR_W[`op]==6'b001000)?1:0;
assign addiu_W=(IR_W[`op]==6'b001001)?1:0;
assign sub_W =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100010)?1:0;
assign sll_W =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b000000)?1:0;
assign srl_W =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b000010)?1:0;
assign and_W =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100100)?1:0;
assign or_W  =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100101)?1:0;
assign xor_W =(IR_W[`op]==6'b000000 && IR_W[`func]==6'b100110)?1:0;
assign bne_W =(IR_W[`op]==6'b000101)?1:0;

assign CAL_R_W=addu_W || subu_W || add_W || sub_W || sll_W || srl_W || and_W || or_W || xor_W;
assign CAL_I_W=ori_W || lui_W || addi_W || addiu_W;
assign store_W=sw_W;
assign load_W =lw_W;
assign b_W    =beq_W || bne_W;


assign stop=
(CAL_R_E && jr_D     &&  IR_E[`rd]==IR_D[`rs] && IR_E[`rd]!=5'b0)||     					    //E:R		D:jr	E[rd]==D[rs]
(CAL_R_E && b_D      && (IR_E[`rd]==IR_D[`rs] || IR_E[`rd]==IR_D[`rt]) && IR_E[`rd]!=5'b0)||    //E:R   	D:beq   E[rd]==D[rs] || E[rd]==D[rt]
(CAL_I_E && jr_D     &&  IR_E[`rt]==IR_D[`rs] && IR_E[`rt]!=5'b0)||     						//E:I		D:jr	E[rt]==D[rs]
(CAL_I_E && b_D      && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]) && IR_E[`rt]!=5'b0)||    //E:I   	D:beq   E[rt]==D[rs] || E[rt]==D[rt]
( load_E && jr_D     &&  IR_E[`rt]==IR_D[`rs] && IR_E[`rt]!=5'b0)||     						//E:load	D:jr	E[rt]==D[rs]
( load_E && b_D      && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]) && IR_E[`rt]!=5'b0)||    //E:load    D:beq   E[rt]==D[rs] || E[rt]==D[rt]
( load_E && CAL_I_D  &&  IR_E[`rt]==IR_D[`rs] && IR_E[`rt]!=5'b0)||     						//E:load	D:I	    E[rt]==D[rs]
( load_E && CAL_R_D  && (IR_E[`rt]==IR_D[`rs] || IR_E[`rt]==IR_D[`rt]) && IR_E[`rt]!=5'b0)||    //E:load    D:R     E[rt]==D[rs] || E[rt]==D[rt]
( load_E && load_D   &&  IR_E[`rt]==IR_D[`rs] && IR_E[`rt]!=5'b0)||                             //E:load    D:load  E[rt]==D[rs]
( load_E && store_D  &&  IR_E[`rt]==IR_D[`rs] && IR_E[`rt]!=5'b0)||							    //E:load    D:store E[rt]==D[rs]
( load_M && jr_D     &&  IR_M[`rt]==IR_D[`rs] && IR_M[`rt]!=5'b0)||     						//M:load	D:jr	M[rt]==D[rs]
( load_M && b_D      && (IR_M[`rt]==IR_D[`rs] || IR_M[`rt]==IR_D[`rt]) && IR_M[`rt]!=5'b0);     //M:load    D:beq   M[rt]==D[rs] || M[rt]==D[rt]
//£¡=00000 £¡=00000 £¡=00000 £¡=00000£¡=00000
assign enable=!stop;
assign clear=stop;

assign MF_RS_D_OP=(
(CAL_R_M && (b_D || jr_D) && IR_M[`rd]==IR_D[`rs] && IR_M[`rd]!=5'b0)||		//M:R		D:beq,jr M[rd]==D[rs] ! =00000
(CAL_I_M && (b_D || jr_D) && IR_M[`rt]==IR_D[`rs] && IR_M[`rt]!=5'b0)		//M:I		D:beq,jr M[rt]==D[rs] ! =00000
)?2'b01:(
(jal_M   && (b_D || jr_D) && IR_D[`rs]==5'd31)								//M:jal     D:beq,jr 5'b31==D[rs] ! =00000
)?2'b10:(
(CAL_R_W && (b_D || jr_D) && IR_W[`rd]==IR_D[`rs] && IR_W[`rd]!=5'b0)||     //W:R		D:beq,jr W[rd]==D[rs] ! =00000
(CAL_I_W && (b_D || jr_D) && IR_W[`rt]==IR_D[`rs] && IR_W[`rt]!=5'b0)||		//W:I       D:beq,jr W[rt]==D[rs] ! =00000
( load_W && (b_D || jr_D) && IR_W[`rt]==IR_D[`rs] && IR_W[`rt]!=5'b0)||		//W:load    D:beq,jr W[rt]==D[rs] ! =00000
(  jal_W && (b_D || jr_D) && IR_D[`rs]==5'd31)								//W:jal     D:beq,jr 31   ==D[rs] ! =00000
)?2'b11:2'b00;


assign MF_RT_D_OP=(
(CAL_R_M && b_D && IR_M[`rd]==IR_D[`rt] && IR_M[`rd]!=5'b0)||		//M:R		D:beq M[rd]==D[rt] ! =00000
(CAL_I_M && b_D && IR_M[`rt]==IR_D[`rt] && IR_M[`rt]!=5'b0)		//M:I		D:beq M[rt]==D[rt] ! =00000
)?2'b01:(
(jal_M   && b_D && IR_D[`rt]==5'd31)								//M:jal     D:beq 5'b31==D[rt] ! =00000
)?2'b10:(
(CAL_R_W && b_D && IR_W[`rd]==IR_D[`rt] && IR_W[`rd]!=5'b0)||     //W:R		D:beq W[rd]==D[rt] ! =00000
(CAL_I_W && b_D && IR_W[`rt]==IR_D[`rt] && IR_W[`rt]!=5'b0)||		//W:I       D:beq W[rt]==D[rt] ! =00000
( load_W && b_D && IR_W[`rt]==IR_D[`rt] && IR_W[`rt]!=5'b0)||		//W:load    D:beq W[rt]==D[rt] ! =00000
(  jal_W && b_D && IR_D[`rt]==5'd31)								//W:jal     D:beq 31   ==D[rt] ! =00000
)?2'b11:2'b00;


assign MF_RS_E_OP=(
(CAL_R_M && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_M[`rd]==IR_E[`rs] && IR_M[`rd]!=5'b0)|| //M:R	  E:R,I,load,store M[rd]==E[rs] !=00000
(CAL_I_M && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_M[`rt]==IR_E[`rs] && IR_M[`rt]!=5'b0)   //M:I   E:R,I,load,store M[rt]==E[rs] !=00000
)?2'b01:(
(jal_M   && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_E[`rs]==5'd31)						  //M:jal E:R,I,load,store E[rs]==31 !=00000
)?2'b10:(
(CAL_R_W && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_W[`rd]==IR_E[`rs] && IR_W[`rd]!=5'b0)||      //W:R		E:R,I,load,store 	W[rd]==D[rt] ! =00000
(CAL_I_W && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_W[`rt]==IR_E[`rs] && IR_W[`rt]!=5'b0)||		//W:I       E:R,I,load,store 	W[rt]==D[rt] ! =00000
( load_W && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_W[`rt]==IR_E[`rs] && IR_W[`rt]!=5'b0)||		//W:load    E:R,I,load,store 	W[rt]==D[rt] ! =00000
(  jal_W && (CAL_R_E || CAL_I_E || load_E || store_E) && IR_E[`rs]==5'd31)								//W:jal     E:R,I,load,store	 31   ==D[rt] ! =00000
)?2'b11:2'b00;


assign MF_RT_E_OP=(
(CAL_R_M && (CAL_R_E || store_E) && IR_M[`rd]==IR_E[`rt] && IR_M[`rd]!=5'b0)|| //M:R	  E:R,store M[rd]==E[rs] !=00000
(CAL_I_M && (CAL_R_E || store_E) && IR_M[`rt]==IR_E[`rt] && IR_M[`rt]!=5'b0)   //M:I   E:R,store M[rt]==E[rs] !=00000
)?2'b01:(
(jal_M   && (CAL_R_E || store_E) && IR_E[`rt]==5'd31)						  //M:jal E:R,store E[rs]==31 !=00000
)?2'b10:(
(CAL_R_W && (CAL_R_E || store_E) && IR_W[`rd]==IR_E[`rt] && IR_W[`rd]!=5'b0)||      //W:R		E:R,store 	W[rd]==D[rt] ! =00000
(CAL_I_W && (CAL_R_E || store_E) && IR_W[`rt]==IR_E[`rt] && IR_W[`rt]!=5'b0)||		//W:I       E:R,store 	W[rt]==D[rt] ! =00000
( load_W && (CAL_R_E || store_E) && IR_W[`rt]==IR_E[`rt] && IR_W[`rt]!=5'b0)||		//W:load    E:R,store 	W[rt]==D[rt] ! =00000
(  jal_W && (CAL_R_E || store_E) && IR_E[`rt]==5'd31)								//W:jal     E:R,store	 31   ==D[rt] ! =00000
)?2'b11:2'b00;


assign MF_RT_M_OP=(
(CAL_R_W && store_M && IR_W[`rd]==IR_M[`rt] && IR_W[`rd]!=5'b0)||
(CAL_I_W && store_M && IR_W[`rt]==IR_M[`rt] && IR_W[`rt]!=5'b0)||
( load_W && store_M && IR_W[`rt]==IR_M[`rt] && IR_W[`rt]!=5'b0)||
(  jal_W && store_M && IR_W[`rt]==5'd31)
)?2'b01:2'b00;

endmodule

