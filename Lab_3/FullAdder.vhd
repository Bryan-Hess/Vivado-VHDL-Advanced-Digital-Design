library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
    generic (
        n : positive := 32   --Generic default to 32-bit
	);
	port (
		K     : IN  STD_LOGIC;
		A     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		B     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Sum   : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout  : OUT STD_LOGIC
	);
end FullAdder;

architecture Behavioral of FullAdder is

    --FullAdderSubtractor componant
	component FullAdderSubtractor is
		port (
            A    : IN  STD_LOGIC; --Value 1
            B    : IN  STD_LOGIC; --Value 2
            Cin  : IN  STD_LOGIC; --Carry in
            Cout : OUT STD_LOGIC; --Carry out
            S    : OUT STD_LOGIC  --Sum
		);
	end component;
	
	--Temporary signals
	SIGNAL Carry : STD_LOGIC_VECTOR(n-1 DOWNTO 0); --Cout of prev adder becomes carry
	SIGNAL Bnew  : STD_LOGIC_VECTOR(n-1 DOWNTO 0); -- B XOR K becomes new B
	
begin
    Bnew(0) <= K xor B(0);
    first_adder: FullAdderSubtractor port map ( 
        A       => A(0), 
	    B       => Bnew(0),
        Cin     => K,
        Cout    => Carry(0),
        S       => Sum(0)
    );
    
    L1:for i in 1 to n-1 generate
        Bnew(i) <= K xor B(i);
        rest_of_adders: FullAdderSubtractor port map ( 
        A       => A(i),
        B       => Bnew(i),
        Cin     => Carry(i-1),
        Cout    => Carry(i),
        S       => Sum(i)
    );
    end generate;
    Cout <= Carry(31);
end Behavioral;
