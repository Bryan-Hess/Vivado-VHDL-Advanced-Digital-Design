library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ComparatorUnit_tb is
end ComparatorUnit_tb;

architecture sim of ComparatorUnit_tb is
    --Comparator Unit Componant
	component ComparatorUnit is 
	   Port(
			A_31: IN STD_LOGIC;
			B_31: IN STD_LOGIC;
			S_31: IN STD_LOGIC;
			CO: IN STD_LOGIC;
			ALUOp: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			R: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
    end component;
    
    signal A_31, B_31, S_31, CO: std_logic;
	signal R: std_logic_vector(31 DOWNTO 0);
	signal ALUOp : std_logic_vector(1 downto 0);
	   
begin
    --Assigns ports to signals
    U: ComparatorUnit port map(
        A_31 => A_31,
        B_31 => B_31,
        S_31 => S_31,
        CO => CO,
        ALUOp => ALUOp,
        R => R
    );
    process
    begin
        --Set these for the first few sims to avoid 'U' (doesn't actually affect outcome)
        A_31 <= '0';
        B_31 <= '0';
        S_31 <= '0';
        CO <= '0';
-- 00---   
        ALUOp <= "00";
        wait for 10 ns;
        assert(R = X"00000000") report "00--- FAILED";
        wait for 10 ns;
-- 01---             
        ALUOp <= "01";
        wait for 10 ns;
        assert(R = X"00000000") report "01--- FAILED";
-- 10000-            
        ALUOp <= "10";
        A_31 <= '0';
        B_31 <= '0';
        S_31 <= '0';
        wait for 10 ns;
        assert(R = X"00000000") report "10000- FAILED";
-- 10001-             
        ALUOp <= "10";
        A_31 <= '0';
        B_31 <= '0';
        S_31 <= '1';
        wait for 10 ns;
        assert(R = X"00000001") report "10001- FAILED";
-- 10110-         
        ALUOp <= "10";
        A_31 <= '1';
        B_31 <= '1';
        S_31 <= '0';
        wait for 10 ns;
        assert(R = X"00000000") report "10110- FAILED";
-- 10111-             
        ALUOp <= "10";
        A_31 <= '1';
        B_31 <= '1';
        S_31 <= '1';
        wait for 10 ns;
        assert(R = X"00000001") report "10111- FAILED";
-- 1010--             
        ALUOp <= "10";
        A_31 <= '1';
        B_31 <= '0';
        S_31 <= '0';
        wait for 10 ns;
        assert(R = X"00000001") report "1010-- FAILED";
-- 1001--            
        ALUOp <= "10";
        A_31 <= '0';
        B_31 <= '1';
        S_31 <= '0';
        wait for 10 ns;
        assert(R = X"00000000") report "1001-- FAILED";
-- 11---1             
        ALUOp <= "11";
        A_31 <= '0';
        B_31 <= '0';
        S_31 <= '0';
        CO <= '1';
        wait for 10 ns;
        assert(R = X"00000000") report "11---1 FAILED";
-- 11---0          
        ALUOp <= "11";
        A_31 <= '0';
        B_31 <= '0';
        S_31 <= '0';
        CO <= '0';
        wait for 10 ns;
        assert(R = X"00000001") report "11---0 FAILED";

    wait;
    end process;
end sim;
