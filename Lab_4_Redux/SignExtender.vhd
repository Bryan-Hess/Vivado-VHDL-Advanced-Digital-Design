library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtender is
    port (
        D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        OP : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        SingExtended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        LeftShifted : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end SignExtender;

architecture Behavioral of SignExtender is
    SIGNAL signExtenSignal : STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    signExtenSignal(31 DOWNTO 16) <= "0000000000000000" when OP = "001101" 
    else "1111111111111111" when D(15) = '1' 
    else "0000000000000000";
    
    signExtenSignal(15 DOWNTO 0) <= D;
    SingExtended <= signExtenSignal;
    LeftShifted <= signExtenSignal(29 DOWNTO 0) & "00";
    
end Behavioral;
