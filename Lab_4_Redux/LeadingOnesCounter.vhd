library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.NUMERIC_STD.all;

entity LeadingOnesCounter is
    port (
        D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Count : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end LeadingOnesCounter;

architecture Behavioral of LeadingOnesCounter is

begin

    process (D)
        variable counter : integer;
        variable stop : boolean;
        
    begin
        counter := 0;
        stop := false;
        
        for i in 31 DOWNTO 0 loop
        
            if (stop = false) then
                if (D(i) = '1') then
                    counter := counter + 1;
                elsif (D(i) = '0') then
                    stop := true;
                end if;
                
            end if;
        end loop;
        
        Count <= STD_LOGIC_VECTOR(to_unsigned(counter, 32));
    end process;

end Behavioral;