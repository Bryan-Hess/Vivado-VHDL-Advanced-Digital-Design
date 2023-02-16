library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.ALL;

entity FullAdder_tb is
end entity;

architecture sim of FullAdder_tb is
    --FullAdder Componant
    component FullAdder is
        generic (
		  n : positive := 32
		);
		port (
		K     : IN  STD_LOGIC;
		A     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		B     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Sum   : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout  : OUT STD_LOGIC
		);
	end component;

    --Signals
	constant n : positive := 32;
	signal K       : STD_LOGIC;
	signal A       : STD_LOGIC_VECTOR(n-1 downto 0);
	signal B       : STD_LOGIC_VECTOR(n-1 downto 0);
	signal Sum     : STD_LOGIC_VECTOR(n-1 downto 0);
	signal Cout    : STD_LOGIC;
	
begin
    --Assigns ports to signals
    DUT: FullAdder
        generic map (
            n     => n
        )
        port map (
            K       => K,
            A       => A,
            B       => B,
            Sum     => Sum,
            Cout    => Cout
        );
        
    process
        variable seed1, seed2: positive;                 -- seed values for random generator
        variable rand: real;                             -- random real-number value in range 0 to 1.0  
        variable range_of_rand : real := real(2**31-1);  -- the range of random values created will be 0 to 2^32-1.
        variable tempA : STD_LOGIC_VECTOR(31 downto 0);
        variable tempB : STD_LOGIC_VECTOR(31 downto 0);
        variable tempS : STD_LOGIC_VECTOR(31 downto 0);
        variable tempCout : std_logic;
    begin
        --Testing Corner Cases
    
        --A+B <= 2^32-1, No Carry Out
        K <= '0';
        A <= "00000000000011111111000000000000";
        B <= "00000000000011111111000000000000";
        wait for 10ns;
        assert(Cout='0')report "Addition 1 Failed";
        
        
        --A+B > 2^32-1, Carry Out
        K <= '0';
        A <= "00000000000000000000000000000001";
        B <= "11111111111111111111111111111111";
        wait for 10ns;
        assert(Cout='1')report "Addition 2 Failed";
        
        
        --A-B > 0, Carry Out
        K <= '1';
        A <= "00000000000000001000000000000000";
        B <= "00000000000000000000000010000000";
        wait for 10ns;
        --tempCout := Cout;
        assert(Cout='1')report "Subtraction 1 Failed";     
        
        
        --A-B = 0, Carry Out
        K <= '1';
        A <= "11111111111111110000000000000000";
        B <= "11111111111111110000000000000000";
        wait for 10ns;
        --assert(S = STD_LOGIC_VECTOR(to_unsigned(i,32))) report "Subtraction 2 Carry Failed";
        assert(Cout='1')report "Subtraction 2 Carry Failed";
        
        --A-B < 0, No Carry Out
        K <= '1';
        A <= "00000000111111110000000000000000";
        B <= "11111111000000000000000000000000";
        wait for 10ns;
        assert(Cout='0')report "Subtraction 3 Failed";
        
        
		
        report "Corner Cases Completed";

    --Random testing:
    
    --50 Addition Cases
    K <= '0'; 
    for i in 0 to 50 loop
        uniform(seed1, seed2, rand);   -- generates random number
        tempA := std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));
        A <= std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));  -- rescale to 0..2^31-1, convert integer part 
        uniform(seed1, seed2, rand);   -- generate random number
        tempB := std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));
        B <= std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));  -- rescale to 0..2^31-1, convert integer part 
        wait for 10 ns;
        tempS := Sum;
        if(not(signed(tempS) = (signed(tempA)+signed(tempB)))) then
            report "Addition Random Testing FAILED!";
        end if;
   end loop;
    
    --50 Subtraction Cases
    K <= '1'; 
    for i in 0 to 15 loop
        uniform(seed1, seed2, rand);   -- generates random number
        tempA := std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));
        A <= std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));  -- rescale to 0..2^31-1, convert integer part 
        uniform(seed1, seed2, rand);   -- generate random number
        tempB := std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));
        B <= std_logic_vector(to_unsigned(integer(rand*range_of_rand), 32));  -- rescale to 0..2^31-1, convert integer part 
        wait for 10 ns;
        tempS := Sum;
        if(not(signed(tempS) = (signed(tempA)-signed(tempB)))) then
            report "Subtraction Random Testing FAILED!";
        end if;
    end loop;
    wait;
        
	end process;
	
end sim;
