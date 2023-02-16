library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegFile is
	generic (
		n : positive := 32
	);
	port (
	    CLK : IN  STD_LOGIC;
	    RST : IN STD_LOGIC;
	    RegWrite : IN  STD_LOGIC;
	    ReadReg1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	    ReadReg2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	    WriteReg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		WriteData : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		ReadData1 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		ReadData2 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
end entity;

architecture rtl of RegFile is

    type reg is ARRAY(n-1 DOWNTO 0) of STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    signal regArray : reg; 

begin        
    ReadData1 <= regArray(to_integer(unsigned(ReadReg1)));
    ReadData2 <= regArray(to_integer(unsigned(ReadReg2))); 

    CLKD : process(CLK, RST)
    begin
        if(RST = '1') then
           for i in 0 to n-1 loop
                regArray(i) <= (others => '0');
           end loop;
        elsif(CLK'event AND CLK = '1') then         
           if(RegWrite = '1') then
              regArray(to_integer(unsigned(WriteReg))) <= WriteData;
           end if;
        end if;
    end process CLKD;
end architecture;
