-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Jan 26 12:23:11 2022
-- Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/Lab_1/Lab_1.srcs/sources_1/bd/Lab_1/ip/Lab_1_FullAdder_0_0/Lab_1_FullAdder_0_0_stub.vhdl
-- Design      : Lab_1_FullAdder_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab_1_FullAdder_0_0 is
  Port ( 
    K : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    B : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Sum : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Cout : out STD_LOGIC
  );

end Lab_1_FullAdder_0_0;

architecture stub of Lab_1_FullAdder_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "K,A[31:0],B[31:0],Sum[31:0],Cout";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "FullAdder,Vivado 2018.3";
begin
end;
