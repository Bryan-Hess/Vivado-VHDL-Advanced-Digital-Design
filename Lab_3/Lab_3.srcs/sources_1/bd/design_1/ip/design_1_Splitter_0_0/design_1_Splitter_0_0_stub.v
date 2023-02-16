// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Feb 22 23:32:08 2022
// Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/ECE_1195/Lab_3/Lab_3.srcs/sources_1/bd/design_1/ip/design_1_Splitter_0_0/design_1_Splitter_0_0_stub.v
// Design      : design_1_Splitter_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "Splitter,Vivado 2018.3" *)
module design_1_Splitter_0_0(DataIn, A, B)
/* synthesis syn_black_box black_box_pad_pin="DataIn[63:0],A[63:32],B[31:0]" */;
  input [63:0]DataIn;
  output [63:32]A;
  output [31:0]B;
endmodule
