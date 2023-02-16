library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Resizer is
    port (
        D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end Resizer;

architecture Behavioral of Resizer is
begin
    with Selector select Q <=
        STD_LOGIC_VECTOR(resize(signed(D(31 DOWNTO 16)), 32)) when "00", --Half Word (Top 16 bits)
        D when "01",                                                     --Word
        STD_LOGIC_VECTOR(resize(signed(D(31 DOWNTO 16)), 32)) when "10", --Half Word (Bottom 16 bits)
        STD_LOGIC_VECTOR(resize(signed(D(31 DOWNTO 24)), 32)) when "11", --Byte
        x"00000000" when others;
end Behavioral;