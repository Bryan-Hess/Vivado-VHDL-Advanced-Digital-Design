library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LeftShifter is
    port (
        RS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        RT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        Immmediate : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Shifted : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end LeftShifter;

architecture Behavioral of LeftShifter is
    signal ImmedShift : STD_LOGIC_VECTOR(25 downto 0);
begin
    ImmedShift  <= RS & RT & Immmediate;
    Shifted <= PC(31 DOWNTO 28) & ImmedShift & "00";
end Behavioral;