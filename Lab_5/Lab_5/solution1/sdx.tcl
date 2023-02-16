# ==============================================================
# File generated on Sat Apr 16 21:08:50 -0400 2022
# Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2018.3 (64-bit)
# SW Build 2405991 on Thu Dec  6 23:38:27 MST 2018
# IP Build 2404404 on Fri Dec  7 01:43:56 MST 2018
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# ==============================================================
add_files -tb ../../vhls/testbench.cpp -cflags { -Wno-unknown-pragmas}
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/convolution.cpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/convolution.hpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/image.cpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/image.hpp
add_files ../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/rock512.pgm
add_files -tb ../../../../../../Desktop/Jr_Year_Spring/ECE_1195/Lab_5/vhls/testbench.cpp -cflags { -Wno-unknown-pragmas}
set_part xc7z020clg400-1
create_clock -name default -period 10
config_export -display_name=hw_conv
config_export -format=ip_catalog
config_export -rtl=vhdl
