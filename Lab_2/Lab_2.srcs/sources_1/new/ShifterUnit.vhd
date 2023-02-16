library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShifterUnit is
    Port( 
        A:  IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        SHAMT:  IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        ALUOp:  IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        R:  OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end ShifterUnit;

architecture Behavioral of ShifterUnit is
    signal  L_0, L_1, L_2, L_3, L_4:    STD_LOGIC_VECTOR (31 DOWNTO 0);
    signal  R_0, R_1, R_2, R_3, R_4:  STD_LOGIC_VECTOR (31 DOWNTO 0);
    signal  ArthR_0, ArthR_1, ArthR_2, ArthR_3, ArthR_4, Fill:  STD_LOGIC_VECTOR (31 DOWNTO 0);
begin
    --Left Logical/Arithmatic Shift
	L_0 <= (A(30 DOWNTO 0) & '0') WHEN SHAMT(0)='1' 
	ELSE A;
	L_1 <= (L_0(29 DOWNTO 0) & "00") WHEN SHAMT(1)='1' 
	ELSE L_0;
	L_2 <= (L_1(27 DOWNTO 0) & "0000") WHEN SHAMT(2)='1' 
	ELSE L_1;
	L_3 <= (L_2(23 DOWNTO 0) & "00000000") WHEN SHAMT(3)='1' 
	ELSE L_2;
	L_4 <= (L_3(15 DOWNTO 0) & "0000000000000000") WHEN SHAMT(4)='1' 
	ELSE L_3;
	

    --Right Logical Shift
	R_0 <= ('0' & A(31 DOWNTO 1)) WHEN SHAMT(0)='1' 
	ELSE A;
	R_1 <= ("00" & R_0(31 DOWNTO 2)) WHEN SHAMT(1)='1' 
	ELSE R_0;
	R_2 <= ("0000" & R_1(31 DOWNTO 4)) WHEN SHAMT(2)='1' 
	ELSE R_1;
	R_3 <= ("00000000" & R_2(31 DOWNTO 8)) WHEN SHAMT(3)='1' 
	ELSE R_2;
	R_4 <= ("0000000000000000" & R_3(31 DOWNTO 16)) WHEN SHAMT(4)='1' 
	ELSE R_3;

    --Right Arithmatic Shift
	Fill <= "00000000000000000000000000000000" WHEN A(31)='0' 
	ELSE "11111111111111111111111111111111";
	ArthR_0 <= (Fill(0) & A(31 DOWNTO 1)) WHEN SHAMT(0)='1' 
	ELSE A;
	ArthR_1 <= (Fill(1 DOWNTO 0) & ArthR_0(31 DOWNTO 2)) WHEN SHAMT(1)='1' 
	ELSE ArthR_0;
	ArthR_2 <= (Fill(3 DOWNTO 0) & ArthR_1(31 DOWNTO 4)) WHEN SHAMT(2)='1' 
	ELSE ArthR_1;
	ArthR_3 <= (Fill(7 DOWNTO 0) & ArthR_2(31 DOWNTO 8)) WHEN SHAMT(3)='1' 
	ELSE ArthR_2;
	ArthR_4 <= (Fill(15 DOWNTO 0) & ArthR_3(31 DOWNTO 16)) WHEN SHAMT(4)='1' 
	ELSE ArthR_3;

    --Mux Results using ALUOp
	R <= ArthR_4 WHEN ALUOp = "11" ELSE
	R_4 WHEN ALUOp = "10" ELSE
	L_4;
	       
end Behavioral;
