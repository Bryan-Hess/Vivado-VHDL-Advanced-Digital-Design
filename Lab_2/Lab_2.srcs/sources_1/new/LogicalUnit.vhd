library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicalUnit is
    Port( 
        A: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        B: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        ALUOp: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        R: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end LogicalUnit;

architecture Behavioral of LogicalUnit is
    
begin
    -- Select for Operation
    -- ALUOp(1) ALUOp(0) Operation
    -- 0        0        AND
    -- 0        1        OR
    -- 1        0        XOR
    -- 1        1        NOR
    
    R <= (A AND B) WHEN ALUOp = "00" ELSE
                (A OR B) WHEN ALUOp = "01" ELSE
                (A XOR B) WHEN ALUOp = "10" ELSE
                (A NOR B) WHEN ALUOp = "11";
end Behavioral;
