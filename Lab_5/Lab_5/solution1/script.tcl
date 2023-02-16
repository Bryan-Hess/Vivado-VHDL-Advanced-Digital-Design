############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
open_project Lab_5
set_top hw_conv
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/rock512.pgm
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/image.hpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/image.cpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/convolution.hpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/convolution.cpp
add_files -tb vhls/testbench.cpp -cflags "-Wno-unknown-pragmas"
open_solution "solution1"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_export -display_name hw_conv -format ip_catalog -rtl vhdl
#source "./Lab_5/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl vhdl -format ip_catalog -display_name "hw_conv"
