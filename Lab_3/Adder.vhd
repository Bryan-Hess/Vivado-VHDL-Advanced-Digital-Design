library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder is
generic (
		n: positive := 64
	);
	Port(
		A: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		B: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		S: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
end Adder;

architecture Behavioral of Adder is
begin
	S <= STD_LOGIC_VECTOR(signed(A) + signed(B));
end Behavioral;
