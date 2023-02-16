library IEEE;library IEEE;
use IEEE.std_logic_1164.all;use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;use ieee.std_logic_arith.ALL;
use IEEE.math_real.ALL;

entity ShifterUnit_tb is
end ShifterUnit_tb;

architecture sim of ShifterUnit_tb is
    --Shifter Unit Componant
    component ShifterUnit is
    Port( 
        A:  IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        SHAMT:  IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        ALUOp:  IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        R:  OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
	end component;

	signal A:  STD_LOGIC_VECTOR (31 DOWNTO 0);
	signal SHAMT:  STD_LOGIC_VECTOR (4 DOWNTO 0);
	signal ALUOp:  STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal R:  STD_LOGIC_VECTOR (31 downto 0);
	signal Expected_R: STD_LOGIC_VECTOR (31 downto 0);

begin
    --Assigns ports to signals
    U: ShifterUnit port map(
        A => A,
        SHAMT => SHAMT,
        ALUOp => ALUOp,
        R => R
    );
    process
    begin
    
--Case 0
    A <= X"FEDCBA98";
	SHAMT <= "00000";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"FEDCBA98";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"FEDCBA98";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FEDCBA98";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;
    
--Case 1
    A <= X"FEDCBA98";
	SHAMT <= "00001";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"FDB97530";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"7F6E5D4C";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FF6E5D4C";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;   
    
--Case 2
    A <= X"FEDCBA98";
	SHAMT <= "00010";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"FB72EA60";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"3FB72EA6";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFB72EA6";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 3
    A <= X"FEDCBA98";
	SHAMT <= "00011";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"F6E5D4C0";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"1FDB9753";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFDB9753";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 4
    A <= X"FEDCBA98";
	SHAMT <= "00100";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"EDCBA980";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0FEDCBA9";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFEDCBA9";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 5
    A <= X"FEDCBA98";
	SHAMT <= "00101";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"DB975300";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"07F6E5D4";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFF6E5D4";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 6
    A <= X"FEDCBA98";
	SHAMT <= "00110";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"B72EA600";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"03FB72EA";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFB72EA";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 7
    A <= X"FEDCBA98";
	SHAMT <= "00111";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"6E5D4C00";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"01FDB975";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFDB975";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 8
    A <= X"FEDCBA98";
	SHAMT <= "01000";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"DCBA9800";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00FEDCBA";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFEDCBA";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 9
    A <= X"FEDCBA98";
	SHAMT <= "01001";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"B9753000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"007F6E5D";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFF6E5D";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 10
    A <= X"FEDCBA98";
	SHAMT <= "01010";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"72EA6000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"003FB72E";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFB72E";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 11
    A <= X"FEDCBA98";
	SHAMT <= "01011";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"E5D4C000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"001FDB97";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFDB97";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 12
    A <= X"FEDCBA98";
	SHAMT <= "01100";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"CBA98000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"000FEDCB";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFEDCB";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 13
    A <= X"FEDCBA98";
	SHAMT <= "01101";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"97530000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0007F6E5";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFF6E5";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 14
    A <= X"FEDCBA98";
	SHAMT <= "01110";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"2EA60000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0003FB72";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFB72";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 15
    A <= X"FEDCBA98";
	SHAMT <= "01111";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"5D4C0000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0001FDB9";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFDB9";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 16
    A <= X"FEDCBA98";
	SHAMT <= "10000";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"BA980000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0000FEDC";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFEDC";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 17
    A <= X"FEDCBA98";
	SHAMT <= "10001";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"75300000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00007F6E";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFF6E";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 18
    A <= X"FEDCBA98";
	SHAMT <= "10010";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"EA600000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00003FB7";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFB7";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 19
    A <= X"FEDCBA98";
	SHAMT <= "10011";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"D4C00000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00001FDB";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFDB";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 20
    A <= X"FEDCBA98";
	SHAMT <= "10100";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"A9800000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00000FED";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFED";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 21
    A <= X"FEDCBA98";
	SHAMT <= "10101";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"53000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"000007F6";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFF6";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 22
    A <= X"FEDCBA98";
	SHAMT <= "10110";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"A6000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"000003FB";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFB";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 23
    A <= X"FEDCBA98";
	SHAMT <= "10111";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"4C000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"000001FD";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFD";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 24
    A <= X"FEDCBA98";
	SHAMT <= "11000";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"98000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"000000FE";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFE";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 25
    A <= X"FEDCBA98";
	SHAMT <= "11001";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"30000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0000007F";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 26
    A <= X"FEDCBA98";
	SHAMT <= "11010";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"60000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0000003F";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 27
    A <= X"FEDCBA98";
	SHAMT <= "11011";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"C0000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0000001F";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 28
    A <= X"FEDCBA98";
	SHAMT <= "11100";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"80000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"0000000F";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 29
    A <= X"FEDCBA98";
	SHAMT <= "11101";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"00000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00000007";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 30
    A <= X"FEDCBA98";
	SHAMT <= "11110";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"00000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00000003";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
	
--Case 31
    A <= X"FEDCBA98";
	SHAMT <= "11111";
	
	--SLL
	ALUOp<= "00";
	Expected_R <= X"00000000";
	assert(R = Expected_R) report "SLL ERROR";
	wait for 10ns;
	
	--SRL
	ALUOp<= "10";
	Expected_R <= X"00000001";
	assert(R = Expected_R) report "SRL ERROR";
	wait for 10ns;
	
	--SRA
	ALUOp<= "11";
	Expected_R <= X"FFFFFFFF";
	assert(R = Expected_R) report "SRA ERROR";
	wait for 10ns;  
    
    wait;
    end process;
end sim;
