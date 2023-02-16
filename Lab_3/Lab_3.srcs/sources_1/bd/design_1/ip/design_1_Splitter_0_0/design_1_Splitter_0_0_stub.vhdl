-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Tue Feb 22 23:32:08 2022
-- Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/ECE_1195/Lab_3/Lab_3.srcs/sources_1/bd/design_1/ip/design_1_Splitter_0_0/design_1_Splitter_0_0_stub.vhdl
-- Design      : design_1_Splitter_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_Splitter_0_0 is
  Port ( 
    DataIn : in STD_LOGIC_VECTOR ( 63 downto 0 );
    A : out STD_LOGIC_VECTOR ( 63 downto 32 );
    B : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end design_1_Splitter_0_0;

architecture stub of design_1_Splitter_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "DataIn[63:0],A[63:32],B[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "Splitter,Vivado 2018.3";
begin
end;
