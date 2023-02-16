library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Multiplier is
    port (
        A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        High : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Low : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end Multiplier;

architecture Behavioral of Multiplier is
    signal R : STD_LOGIC_VECTOR(63 DOWNTO 0);
begin
    R <= STD_LOGIC_VECTOR(unsigned(A) * unsigned(B));
    High <= R(63 DOWNTO 32);
    Low <= R(31 DOWNTO 0);
end Behavioral;