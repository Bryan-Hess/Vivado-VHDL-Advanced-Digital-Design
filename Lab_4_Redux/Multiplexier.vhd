library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Mux is
	generic (
		n : positive := 32
	);
	port (
		Sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		D0 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		D1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		D2 : IN std_logic_vector(n - 1 DOWNTO 0);
		D3 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
end Mux;

architecture Behavioral of Mux is

begin
	with Sel select Q <=
		D0 when "00",
		D1 when "01",
		D2 when "10",
		D3 when "11",
	    D0 when others;
end Behavioral;