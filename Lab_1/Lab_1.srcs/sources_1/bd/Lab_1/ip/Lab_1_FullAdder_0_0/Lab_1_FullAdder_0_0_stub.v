// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Jan 26 12:23:11 2022
// Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/Lab_1/Lab_1.srcs/sources_1/bd/Lab_1/ip/Lab_1_FullAdder_0_0/Lab_1_FullAdder_0_0_stub.v
// Design      : Lab_1_FullAdder_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "FullAdder,Vivado 2018.3" *)
module Lab_1_FullAdder_0_0(K, A, B, Sum, Cout)
/* synthesis syn_black_box black_box_pad_pin="K,A[31:0],B[31:0],Sum[31:0],Cout" */;
  input K;
  input [31:0]A;
  input [31:0]B;
  output [31:0]Sum;
  output Cout;
endmodule
