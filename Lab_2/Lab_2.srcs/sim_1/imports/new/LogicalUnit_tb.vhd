library IEEE;library IEEE;
use IEEE.std_logic_1164.all;use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;use ieee.std_logic_arith.ALL;
use IEEE.math_real.ALL;

entity LogicalUnit_tb is
end LogicalUnit_tb;

architecture sim of LogicalUnit_tb is
    --Logical Unit Componant
    component LogicalUnit is
    Port( 
        A:  STD_LOGIC_VECTOR (31 downto 0);
        B: IN STD_LOGIC_VECTOR (31 downto 0);
        ALUOp:  IN STD_LOGIC_VECTOR (1 downto 0);
        R:   OUT STD_LOGIC_VECTOR (31 downto 0)   
    );
    end component;

    signal A: STD_LOGIC_VECTOR(31 downto 0);
    signal B: STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp  : STD_LOGIC_VECTOR(1 downto 0);
    signal R : STD_LOGIC_VECTOR(31 downto 0);

begin
--Assigns ports to signals
    U: LogicalUnit port map(
        A => A,
        B => B,
        ALUOp => ALUOp,
        R => R
    );
    process
    begin
        for i in -100 to 100 loop
            --Sets A and B from -100 to 100
            A <= std_logic_vector(to_signed(i, 32));
            B <= std_logic_vector(to_signed(i, 32));
            wait for 10ns;
            
            --Testing AND
            ALUOp <= "00";
            wait for 10ns;
            assert(R = std_logic_vector(A AND B)) report  "AND ERROR";
            
            --Testing OR
            ALUOp <= "01";
            wait for 10ns;
            assert(R = std_logic_vector(A OR B)) report  "OR ERROR";  
                       
            --Testing XOR
            ALUOp <= "10";
            wait for 10ns;
            assert(R = std_logic_vector(A XOR B)) report  "XOR ERROR";
            
            --Testing NOR
            ALUOp <= "11";
            wait for 10ns;
            assert(R = std_logic_vector(A NOR B)) report  "NOR ERROR";
            
        end loop;
        wait;
    end process;
end sim;
