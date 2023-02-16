library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
	port(
		EN: in std_logic;
		RST: in std_logic;
		count: out std_logic_vector(4 downto 0);
		done:out std_logic
	);
end Counter;

architecture Behavioral of Counter is

	signal unsignedCount: unsigned(5 downto 0);

begin
	count <= std_logic_vector(unsignedCount(4 downto 0));
	done <= '1' when unsignedCount = "100000" else '0';
	process(RST,EN)
	begin
		if RST = '1' then --Reset data when reset is enabled 
			unsignedCount <= "000000";
		elsif EN'event and EN = '1' and unsignedCount /= "100000" then
			unsignedCount <= unsignedCount + 1; 
		end if;
	end process;

end Behavioral;
