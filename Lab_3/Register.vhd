library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg is
	generic (
		n: positive := 64
	);
	Port (
		CLK: IN STD_LOGIC;
		D: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		EN: IN STD_LOGIC;
		RST: IN STD_LOGIC;
		Q: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
end Reg;

architecture Behavioral of Reg is
    
begin
	CLKD: process(CLK, RST)
	begin
		if (RST = '1') then
		  Q <= STD_LOGIC_VECTOR(to_unsigned(0, n));
		elsif (CLK'event and CLK = '1') then
			if EN = '1'  then
				Q <= D;
			end if;
		end if;		
	end process CLKD;
end Behavioral;
