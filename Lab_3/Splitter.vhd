library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Splitter is
	generic(
		n: positive:= 32
	);
	port(
		DataIn: IN STD_LOGIC_VECTOR(n*2-1 DOWNTO 0);
		A: OUT STD_LOGIC_VECTOR(n*2-1 DOWNTO n);
		B: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
end Splitter;

architecture Behavioral of Splitter is 

begin
	A <= DataIn(n*2-1 DOWNTO n);
	B <= DataIn(n-1 DOWNTO 0);
end Behavioral;