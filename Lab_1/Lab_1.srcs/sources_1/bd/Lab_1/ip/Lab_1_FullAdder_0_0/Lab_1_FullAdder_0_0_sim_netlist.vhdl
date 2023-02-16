-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Jan 26 12:23:11 2022
-- Host        : DESKTOP-3FOR1BS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/Bakuboys101/Desktop/Jr_Year_Spring/Lab_1/Lab_1.srcs/sources_1/bd/Lab_1/ip/Lab_1_FullAdder_0_0/Lab_1_FullAdder_0_0_sim_netlist.vhdl
-- Design      : Lab_1_FullAdder_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Lab_1_FullAdder_0_0 is
  port (
    K : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 31 downto 0 );
    B : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Sum : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Cout : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Lab_1_FullAdder_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Lab_1_FullAdder_0_0 : entity is "Lab_1_FullAdder_0_0,FullAdder,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Lab_1_FullAdder_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Lab_1_FullAdder_0_0 : entity is "package_project";
  attribute x_core_info : string;
  attribute x_core_info of Lab_1_FullAdder_0_0 : entity is "FullAdder,Vivado 2018.3";
end Lab_1_FullAdder_0_0;

architecture STRUCTURE of Lab_1_FullAdder_0_0 is
  signal \U0/Carry_1\ : STD_LOGIC;
  signal \U0/Carry_11\ : STD_LOGIC;
  signal \U0/Carry_13\ : STD_LOGIC;
  signal \U0/Carry_15\ : STD_LOGIC;
  signal \U0/Carry_17\ : STD_LOGIC;
  signal \U0/Carry_19\ : STD_LOGIC;
  signal \U0/Carry_21\ : STD_LOGIC;
  signal \U0/Carry_23\ : STD_LOGIC;
  signal \U0/Carry_25\ : STD_LOGIC;
  signal \U0/Carry_27\ : STD_LOGIC;
  signal \U0/Carry_29\ : STD_LOGIC;
  signal \U0/Carry_3\ : STD_LOGIC;
  signal \U0/Carry_5\ : STD_LOGIC;
  signal \U0/Carry_7\ : STD_LOGIC;
  signal \U0/Carry_9\ : STD_LOGIC;
begin
Cout_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(31),
      I1 => B(30),
      I2 => K,
      I3 => \U0/Carry_29\,
      I4 => A(30),
      I5 => B(31),
      O => Cout
    );
\Sum[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => B(0),
      I1 => A(0),
      O => Sum(0)
    );
\Sum[10]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(10),
      I2 => A(10),
      I3 => \U0/Carry_9\,
      O => Sum(10)
    );
\Sum[11]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(11),
      I1 => A(11),
      I2 => A(10),
      I3 => \U0/Carry_9\,
      I4 => K,
      I5 => B(10),
      O => Sum(11)
    );
\Sum[11]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(9),
      I1 => B(8),
      I2 => K,
      I3 => \U0/Carry_7\,
      I4 => A(8),
      I5 => B(9),
      O => \U0/Carry_9\
    );
\Sum[12]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(12),
      I2 => A(12),
      I3 => \U0/Carry_11\,
      O => Sum(12)
    );
\Sum[13]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(13),
      I1 => A(13),
      I2 => A(12),
      I3 => \U0/Carry_11\,
      I4 => K,
      I5 => B(12),
      O => Sum(13)
    );
\Sum[13]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(11),
      I1 => B(10),
      I2 => K,
      I3 => \U0/Carry_9\,
      I4 => A(10),
      I5 => B(11),
      O => \U0/Carry_11\
    );
\Sum[14]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(14),
      I2 => A(14),
      I3 => \U0/Carry_13\,
      O => Sum(14)
    );
\Sum[15]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(15),
      I1 => A(15),
      I2 => A(14),
      I3 => \U0/Carry_13\,
      I4 => K,
      I5 => B(14),
      O => Sum(15)
    );
\Sum[15]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(13),
      I1 => B(12),
      I2 => K,
      I3 => \U0/Carry_11\,
      I4 => A(12),
      I5 => B(13),
      O => \U0/Carry_13\
    );
\Sum[16]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(16),
      I2 => A(16),
      I3 => \U0/Carry_15\,
      O => Sum(16)
    );
\Sum[17]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(17),
      I1 => A(17),
      I2 => A(16),
      I3 => \U0/Carry_15\,
      I4 => K,
      I5 => B(16),
      O => Sum(17)
    );
\Sum[17]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(15),
      I1 => B(14),
      I2 => K,
      I3 => \U0/Carry_13\,
      I4 => A(14),
      I5 => B(15),
      O => \U0/Carry_15\
    );
\Sum[18]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(18),
      I2 => A(18),
      I3 => \U0/Carry_17\,
      O => Sum(18)
    );
\Sum[19]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(19),
      I1 => A(19),
      I2 => A(18),
      I3 => \U0/Carry_17\,
      I4 => K,
      I5 => B(18),
      O => Sum(19)
    );
\Sum[19]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(17),
      I1 => B(16),
      I2 => K,
      I3 => \U0/Carry_15\,
      I4 => A(16),
      I5 => B(17),
      O => \U0/Carry_17\
    );
\Sum[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69966666"
    )
        port map (
      I0 => B(1),
      I1 => A(1),
      I2 => A(0),
      I3 => K,
      I4 => B(0),
      O => Sum(1)
    );
\Sum[20]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(20),
      I2 => A(20),
      I3 => \U0/Carry_19\,
      O => Sum(20)
    );
\Sum[21]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(21),
      I1 => A(21),
      I2 => A(20),
      I3 => \U0/Carry_19\,
      I4 => K,
      I5 => B(20),
      O => Sum(21)
    );
\Sum[21]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(19),
      I1 => B(18),
      I2 => K,
      I3 => \U0/Carry_17\,
      I4 => A(18),
      I5 => B(19),
      O => \U0/Carry_19\
    );
\Sum[22]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(22),
      I2 => A(22),
      I3 => \U0/Carry_21\,
      O => Sum(22)
    );
\Sum[23]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(23),
      I1 => A(23),
      I2 => A(22),
      I3 => \U0/Carry_21\,
      I4 => K,
      I5 => B(22),
      O => Sum(23)
    );
\Sum[23]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(21),
      I1 => B(20),
      I2 => K,
      I3 => \U0/Carry_19\,
      I4 => A(20),
      I5 => B(21),
      O => \U0/Carry_21\
    );
\Sum[24]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(24),
      I2 => A(24),
      I3 => \U0/Carry_23\,
      O => Sum(24)
    );
\Sum[25]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(25),
      I1 => A(25),
      I2 => A(24),
      I3 => \U0/Carry_23\,
      I4 => K,
      I5 => B(24),
      O => Sum(25)
    );
\Sum[25]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(23),
      I1 => B(22),
      I2 => K,
      I3 => \U0/Carry_21\,
      I4 => A(22),
      I5 => B(23),
      O => \U0/Carry_23\
    );
\Sum[26]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(26),
      I2 => A(26),
      I3 => \U0/Carry_25\,
      O => Sum(26)
    );
\Sum[27]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(27),
      I1 => A(27),
      I2 => A(26),
      I3 => \U0/Carry_25\,
      I4 => K,
      I5 => B(26),
      O => Sum(27)
    );
\Sum[27]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(25),
      I1 => B(24),
      I2 => K,
      I3 => \U0/Carry_23\,
      I4 => A(24),
      I5 => B(25),
      O => \U0/Carry_25\
    );
\Sum[28]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(28),
      I2 => A(28),
      I3 => \U0/Carry_27\,
      O => Sum(28)
    );
\Sum[29]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(29),
      I1 => A(29),
      I2 => A(28),
      I3 => \U0/Carry_27\,
      I4 => K,
      I5 => B(28),
      O => Sum(29)
    );
\Sum[29]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(27),
      I1 => B(26),
      I2 => K,
      I3 => \U0/Carry_25\,
      I4 => A(26),
      I5 => B(27),
      O => \U0/Carry_27\
    );
\Sum[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(2),
      I2 => A(2),
      I3 => \U0/Carry_1\,
      O => Sum(2)
    );
\Sum[30]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(30),
      I2 => A(30),
      I3 => \U0/Carry_29\,
      O => Sum(30)
    );
\Sum[31]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(31),
      I1 => A(31),
      I2 => A(30),
      I3 => \U0/Carry_29\,
      I4 => K,
      I5 => B(30),
      O => Sum(31)
    );
\Sum[31]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(29),
      I1 => B(28),
      I2 => K,
      I3 => \U0/Carry_27\,
      I4 => A(28),
      I5 => B(29),
      O => \U0/Carry_29\
    );
\Sum[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(3),
      I1 => A(3),
      I2 => A(2),
      I3 => \U0/Carry_1\,
      I4 => K,
      I5 => B(2),
      O => Sum(3)
    );
\Sum[3]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AE2AF8B0"
    )
        port map (
      I0 => A(1),
      I1 => B(0),
      I2 => K,
      I3 => A(0),
      I4 => B(1),
      O => \U0/Carry_1\
    );
\Sum[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(4),
      I2 => A(4),
      I3 => \U0/Carry_3\,
      O => Sum(4)
    );
\Sum[5]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(5),
      I1 => A(5),
      I2 => A(4),
      I3 => \U0/Carry_3\,
      I4 => K,
      I5 => B(4),
      O => Sum(5)
    );
\Sum[5]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(3),
      I1 => B(2),
      I2 => K,
      I3 => \U0/Carry_1\,
      I4 => A(2),
      I5 => B(3),
      O => \U0/Carry_3\
    );
\Sum[6]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(6),
      I2 => A(6),
      I3 => \U0/Carry_5\,
      O => Sum(6)
    );
\Sum[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(7),
      I1 => A(7),
      I2 => A(6),
      I3 => \U0/Carry_5\,
      I4 => K,
      I5 => B(6),
      O => Sum(7)
    );
\Sum[7]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(5),
      I1 => B(4),
      I2 => K,
      I3 => \U0/Carry_3\,
      I4 => A(4),
      I5 => B(5),
      O => \U0/Carry_5\
    );
\Sum[8]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => K,
      I1 => B(8),
      I2 => A(8),
      I3 => \U0/Carry_7\,
      O => Sum(8)
    );
\Sum[9]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999999666699666"
    )
        port map (
      I0 => B(9),
      I1 => A(9),
      I2 => A(8),
      I3 => \U0/Carry_7\,
      I4 => K,
      I5 => B(8),
      O => Sum(9)
    );
\Sum[9]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF2E2E0AFAB8B8A0"
    )
        port map (
      I0 => A(7),
      I1 => B(6),
      I2 => K,
      I3 => \U0/Carry_5\,
      I4 => A(6),
      I5 => B(7),
      O => \U0/Carry_7\
    );
end STRUCTURE;
