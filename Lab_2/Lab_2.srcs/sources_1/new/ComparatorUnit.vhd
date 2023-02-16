library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;

entity ComparatorUnit is
	Port(
			A_31: IN STD_LOGIC;
			B_31: IN STD_LOGIC;
			S_31: IN STD_LOGIC;
			CO: IN STD_LOGIC;
			ALUOp: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			R: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end ComparatorUnit;

architecture Behavioral of ComparatorUnit is
    signal temp: std_logic_vector(5 downto 0);
    --temp represents the following bits concatenated for convenience
    --ALUOp(1)  ALUOp(0)    A_31    B_31    S_31    CO

begin
    --Truth Table for Comparator
    --ALUOp(1)  ALUOp(0)    A_31    B_31    S_31    CO      R
    --0         0           x       x       x       x       X"00000000"
    --0         1           x       x       x       x       X"00000000"
    --1         0           0       0       0       x       X"00000000"
    --1         0           0       0       1       x       X"00000001"
    --1         0           1       1       0       x       X"00000000"
    --1         0           1       1       1       x       X"00000001"
    --1         0           1       0       x       x       X"00000001"
    --1         0           0       1       x       x       X"00000000"
    --1         1           x       x       x       1       X"00000000"
    --1         1           x       x       x       0       X"00000001"
    
    temp <= (ALUOp & A_31 & B_31 & S_31 & CO);
    R <= X"00000001" WHEN std_match(temp, "10001-") ELSE
         X"00000001" WHEN std_match(temp, "10111-") ELSE
         X"00000001" WHEN std_match(temp, "1010--") ELSE
         X"00000001" WHEN std_match(temp, "11---0") ELSE
         X"00000000";

end Behavioral;
