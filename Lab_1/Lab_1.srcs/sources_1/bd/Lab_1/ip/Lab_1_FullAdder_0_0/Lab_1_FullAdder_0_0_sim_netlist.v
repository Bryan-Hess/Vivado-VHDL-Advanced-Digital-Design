// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Jan 26 12:23:11 2022
// Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/Lab_1/Lab_1.srcs/sources_1/bd/Lab_1/ip/Lab_1_FullAdder_0_0/Lab_1_FullAdder_0_0_sim_netlist.v
// Design      : Lab_1_FullAdder_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Lab_1_FullAdder_0_0,FullAdder,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "package_project" *) 
(* x_core_info = "FullAdder,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module Lab_1_FullAdder_0_0
   (K,
    A,
    B,
    Sum,
    Cout);
  input K;
  input [31:0]A;
  input [31:0]B;
  output [31:0]Sum;
  output Cout;

  wire [31:0]A;
  wire [31:0]B;
  wire Cout;
  wire K;
  wire [31:0]Sum;
  wire \U0/Carry_1 ;
  wire \U0/Carry_11 ;
  wire \U0/Carry_13 ;
  wire \U0/Carry_15 ;
  wire \U0/Carry_17 ;
  wire \U0/Carry_19 ;
  wire \U0/Carry_21 ;
  wire \U0/Carry_23 ;
  wire \U0/Carry_25 ;
  wire \U0/Carry_27 ;
  wire \U0/Carry_29 ;
  wire \U0/Carry_3 ;
  wire \U0/Carry_5 ;
  wire \U0/Carry_7 ;
  wire \U0/Carry_9 ;

  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    Cout_INST_0
       (.I0(A[31]),
        .I1(B[30]),
        .I2(K),
        .I3(\U0/Carry_29 ),
        .I4(A[30]),
        .I5(B[31]),
        .O(Cout));
  LUT2 #(
    .INIT(4'h6)) 
    \Sum[0]_INST_0 
       (.I0(B[0]),
        .I1(A[0]),
        .O(Sum[0]));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[10]_INST_0 
       (.I0(K),
        .I1(B[10]),
        .I2(A[10]),
        .I3(\U0/Carry_9 ),
        .O(Sum[10]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[11]_INST_0 
       (.I0(B[11]),
        .I1(A[11]),
        .I2(A[10]),
        .I3(\U0/Carry_9 ),
        .I4(K),
        .I5(B[10]),
        .O(Sum[11]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[11]_INST_0_i_1 
       (.I0(A[9]),
        .I1(B[8]),
        .I2(K),
        .I3(\U0/Carry_7 ),
        .I4(A[8]),
        .I5(B[9]),
        .O(\U0/Carry_9 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[12]_INST_0 
       (.I0(K),
        .I1(B[12]),
        .I2(A[12]),
        .I3(\U0/Carry_11 ),
        .O(Sum[12]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[13]_INST_0 
       (.I0(B[13]),
        .I1(A[13]),
        .I2(A[12]),
        .I3(\U0/Carry_11 ),
        .I4(K),
        .I5(B[12]),
        .O(Sum[13]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[13]_INST_0_i_1 
       (.I0(A[11]),
        .I1(B[10]),
        .I2(K),
        .I3(\U0/Carry_9 ),
        .I4(A[10]),
        .I5(B[11]),
        .O(\U0/Carry_11 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[14]_INST_0 
       (.I0(K),
        .I1(B[14]),
        .I2(A[14]),
        .I3(\U0/Carry_13 ),
        .O(Sum[14]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[15]_INST_0 
       (.I0(B[15]),
        .I1(A[15]),
        .I2(A[14]),
        .I3(\U0/Carry_13 ),
        .I4(K),
        .I5(B[14]),
        .O(Sum[15]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[15]_INST_0_i_1 
       (.I0(A[13]),
        .I1(B[12]),
        .I2(K),
        .I3(\U0/Carry_11 ),
        .I4(A[12]),
        .I5(B[13]),
        .O(\U0/Carry_13 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[16]_INST_0 
       (.I0(K),
        .I1(B[16]),
        .I2(A[16]),
        .I3(\U0/Carry_15 ),
        .O(Sum[16]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[17]_INST_0 
       (.I0(B[17]),
        .I1(A[17]),
        .I2(A[16]),
        .I3(\U0/Carry_15 ),
        .I4(K),
        .I5(B[16]),
        .O(Sum[17]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[17]_INST_0_i_1 
       (.I0(A[15]),
        .I1(B[14]),
        .I2(K),
        .I3(\U0/Carry_13 ),
        .I4(A[14]),
        .I5(B[15]),
        .O(\U0/Carry_15 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[18]_INST_0 
       (.I0(K),
        .I1(B[18]),
        .I2(A[18]),
        .I3(\U0/Carry_17 ),
        .O(Sum[18]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[19]_INST_0 
       (.I0(B[19]),
        .I1(A[19]),
        .I2(A[18]),
        .I3(\U0/Carry_17 ),
        .I4(K),
        .I5(B[18]),
        .O(Sum[19]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[19]_INST_0_i_1 
       (.I0(A[17]),
        .I1(B[16]),
        .I2(K),
        .I3(\U0/Carry_15 ),
        .I4(A[16]),
        .I5(B[17]),
        .O(\U0/Carry_17 ));
  LUT5 #(
    .INIT(32'h69966666)) 
    \Sum[1]_INST_0 
       (.I0(B[1]),
        .I1(A[1]),
        .I2(A[0]),
        .I3(K),
        .I4(B[0]),
        .O(Sum[1]));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[20]_INST_0 
       (.I0(K),
        .I1(B[20]),
        .I2(A[20]),
        .I3(\U0/Carry_19 ),
        .O(Sum[20]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[21]_INST_0 
       (.I0(B[21]),
        .I1(A[21]),
        .I2(A[20]),
        .I3(\U0/Carry_19 ),
        .I4(K),
        .I5(B[20]),
        .O(Sum[21]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[21]_INST_0_i_1 
       (.I0(A[19]),
        .I1(B[18]),
        .I2(K),
        .I3(\U0/Carry_17 ),
        .I4(A[18]),
        .I5(B[19]),
        .O(\U0/Carry_19 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[22]_INST_0 
       (.I0(K),
        .I1(B[22]),
        .I2(A[22]),
        .I3(\U0/Carry_21 ),
        .O(Sum[22]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[23]_INST_0 
       (.I0(B[23]),
        .I1(A[23]),
        .I2(A[22]),
        .I3(\U0/Carry_21 ),
        .I4(K),
        .I5(B[22]),
        .O(Sum[23]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[23]_INST_0_i_1 
       (.I0(A[21]),
        .I1(B[20]),
        .I2(K),
        .I3(\U0/Carry_19 ),
        .I4(A[20]),
        .I5(B[21]),
        .O(\U0/Carry_21 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[24]_INST_0 
       (.I0(K),
        .I1(B[24]),
        .I2(A[24]),
        .I3(\U0/Carry_23 ),
        .O(Sum[24]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[25]_INST_0 
       (.I0(B[25]),
        .I1(A[25]),
        .I2(A[24]),
        .I3(\U0/Carry_23 ),
        .I4(K),
        .I5(B[24]),
        .O(Sum[25]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[25]_INST_0_i_1 
       (.I0(A[23]),
        .I1(B[22]),
        .I2(K),
        .I3(\U0/Carry_21 ),
        .I4(A[22]),
        .I5(B[23]),
        .O(\U0/Carry_23 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[26]_INST_0 
       (.I0(K),
        .I1(B[26]),
        .I2(A[26]),
        .I3(\U0/Carry_25 ),
        .O(Sum[26]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[27]_INST_0 
       (.I0(B[27]),
        .I1(A[27]),
        .I2(A[26]),
        .I3(\U0/Carry_25 ),
        .I4(K),
        .I5(B[26]),
        .O(Sum[27]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[27]_INST_0_i_1 
       (.I0(A[25]),
        .I1(B[24]),
        .I2(K),
        .I3(\U0/Carry_23 ),
        .I4(A[24]),
        .I5(B[25]),
        .O(\U0/Carry_25 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[28]_INST_0 
       (.I0(K),
        .I1(B[28]),
        .I2(A[28]),
        .I3(\U0/Carry_27 ),
        .O(Sum[28]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[29]_INST_0 
       (.I0(B[29]),
        .I1(A[29]),
        .I2(A[28]),
        .I3(\U0/Carry_27 ),
        .I4(K),
        .I5(B[28]),
        .O(Sum[29]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[29]_INST_0_i_1 
       (.I0(A[27]),
        .I1(B[26]),
        .I2(K),
        .I3(\U0/Carry_25 ),
        .I4(A[26]),
        .I5(B[27]),
        .O(\U0/Carry_27 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[2]_INST_0 
       (.I0(K),
        .I1(B[2]),
        .I2(A[2]),
        .I3(\U0/Carry_1 ),
        .O(Sum[2]));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[30]_INST_0 
       (.I0(K),
        .I1(B[30]),
        .I2(A[30]),
        .I3(\U0/Carry_29 ),
        .O(Sum[30]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[31]_INST_0 
       (.I0(B[31]),
        .I1(A[31]),
        .I2(A[30]),
        .I3(\U0/Carry_29 ),
        .I4(K),
        .I5(B[30]),
        .O(Sum[31]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[31]_INST_0_i_1 
       (.I0(A[29]),
        .I1(B[28]),
        .I2(K),
        .I3(\U0/Carry_27 ),
        .I4(A[28]),
        .I5(B[29]),
        .O(\U0/Carry_29 ));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[3]_INST_0 
       (.I0(B[3]),
        .I1(A[3]),
        .I2(A[2]),
        .I3(\U0/Carry_1 ),
        .I4(K),
        .I5(B[2]),
        .O(Sum[3]));
  LUT5 #(
    .INIT(32'hAE2AF8B0)) 
    \Sum[3]_INST_0_i_1 
       (.I0(A[1]),
        .I1(B[0]),
        .I2(K),
        .I3(A[0]),
        .I4(B[1]),
        .O(\U0/Carry_1 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[4]_INST_0 
       (.I0(K),
        .I1(B[4]),
        .I2(A[4]),
        .I3(\U0/Carry_3 ),
        .O(Sum[4]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[5]_INST_0 
       (.I0(B[5]),
        .I1(A[5]),
        .I2(A[4]),
        .I3(\U0/Carry_3 ),
        .I4(K),
        .I5(B[4]),
        .O(Sum[5]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[5]_INST_0_i_1 
       (.I0(A[3]),
        .I1(B[2]),
        .I2(K),
        .I3(\U0/Carry_1 ),
        .I4(A[2]),
        .I5(B[3]),
        .O(\U0/Carry_3 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[6]_INST_0 
       (.I0(K),
        .I1(B[6]),
        .I2(A[6]),
        .I3(\U0/Carry_5 ),
        .O(Sum[6]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[7]_INST_0 
       (.I0(B[7]),
        .I1(A[7]),
        .I2(A[6]),
        .I3(\U0/Carry_5 ),
        .I4(K),
        .I5(B[6]),
        .O(Sum[7]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[7]_INST_0_i_1 
       (.I0(A[5]),
        .I1(B[4]),
        .I2(K),
        .I3(\U0/Carry_3 ),
        .I4(A[4]),
        .I5(B[5]),
        .O(\U0/Carry_5 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \Sum[8]_INST_0 
       (.I0(K),
        .I1(B[8]),
        .I2(A[8]),
        .I3(\U0/Carry_7 ),
        .O(Sum[8]));
  LUT6 #(
    .INIT(64'h6999999666699666)) 
    \Sum[9]_INST_0 
       (.I0(B[9]),
        .I1(A[9]),
        .I2(A[8]),
        .I3(\U0/Carry_7 ),
        .I4(K),
        .I5(B[8]),
        .O(Sum[9]));
  LUT6 #(
    .INIT(64'hAF2E2E0AFAB8B8A0)) 
    \Sum[9]_INST_0_i_1 
       (.I0(A[7]),
        .I1(B[6]),
        .I2(K),
        .I3(\U0/Carry_5 ),
        .I4(A[6]),
        .I5(B[7]),
        .O(\U0/Carry_7 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
