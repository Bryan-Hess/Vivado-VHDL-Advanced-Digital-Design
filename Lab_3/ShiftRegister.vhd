library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
	generic (
		n: positive := 64
	);
	port(
		CLK: IN STD_LOGIC;
		D: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		EN: IN STD_LOGIC;
		RST: IN STD_LOGIC;
		LOAD: IN STD_LOGIC;
		CON: IN STD_LOGIC; -- 0 = Shift Left,  1 = Shift Right
		Q: INOUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
end ShiftRegister;

architecture Behavioral of ShiftRegister is

	--SIGNAL Q_temp: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	
begin

	--Q <= Q_temp;
	process(CLK, RST)
	begin
		if RST = '1' then --All 0s for reset
            Q <= (others => '0');
		elsif(CLK'event and CLK = '1' and EN = '1') then
			if LOAD = '1' then --Load A/B
				Q <= D;
			elsif CON ='0' then --Left shift
				Q <= Q(n-2 DOWNTO 0) & '0';
			elsif CON ='1' then --Right shift
				Q <= '0' & Q(n-1 DOWNTO 1);
--			else --Default
--				Q_temp <= D;
			end if;
		end if;		
	end process;


end Behavioral;
