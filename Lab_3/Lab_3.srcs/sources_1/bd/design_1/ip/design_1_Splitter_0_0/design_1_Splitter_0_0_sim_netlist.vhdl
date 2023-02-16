-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Tue Feb 22 23:32:08 2022
-- Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/ECE_1195/Lab_3/Lab_3.srcs/sources_1/bd/design_1/ip/design_1_Splitter_0_0/design_1_Splitter_0_0_sim_netlist.vhdl
-- Design      : design_1_Splitter_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Splitter_0_0 is
  port (
    DataIn : in STD_LOGIC_VECTOR ( 63 downto 0 );
    A : out STD_LOGIC_VECTOR ( 63 downto 32 );
    B : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_Splitter_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Splitter_0_0 : entity is "design_1_Splitter_0_0,Splitter,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_Splitter_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_Splitter_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_Splitter_0_0 : entity is "Splitter,Vivado 2018.3";
end design_1_Splitter_0_0;

architecture STRUCTURE of design_1_Splitter_0_0 is
  signal \^datain\ : STD_LOGIC_VECTOR ( 63 downto 0 );
begin
  A(63 downto 32) <= \^datain\(63 downto 32);
  B(31 downto 0) <= \^datain\(31 downto 0);
  \^datain\(63 downto 0) <= DataIn(63 downto 0);
end STRUCTURE;
