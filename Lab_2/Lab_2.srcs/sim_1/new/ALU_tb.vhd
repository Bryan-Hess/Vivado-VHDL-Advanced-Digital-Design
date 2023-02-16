library IEEE;library IEEE;
use IEEE.std_logic_1164.all;use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;use ieee.std_logic_arith.ALL;
use IEEE.math_real.ALL;

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture sim of ALU_tb is
    component ALU is
        Port( 
	        A: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			B: IN STD_LOGIC_VECTOR (31 DOWNTO 0);	
			ALUOp: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			SHAMT: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			R: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			Zero: OUT STD_LOGIC;
			Overflow: OUT STD_LOGIC
		);
    end component;
    
    signal A:  STD_LOGIC_VECTOR (31 DOWNTO 0);
    signal B:  STD_LOGIC_VECTOR (31 DOWNTO 0);
    signal ALUOp:  STD_LOGIC_VECTOR (3 DOWNTO 0);
	signal SHAMT:  STD_LOGIC_VECTOR (4 DOWNTO 0);
	signal R: STD_LOGIC_VECTOR (31 downto 0);
	signal Zero: STD_LOGIC;
	signal Overflow: STD_LOGIC;
    
begin
    U: ALU port map (
        A => A,
        B => B,
        ALUOp => ALUOp,
        SHAMT => SHAMT,
        R => R,
        Zero => Zero,
        Overflow => Overflow
    );
    process
    begin
        --Loops i from -50 to 50 and j from -50 to 50 
        for i in -50 to 50 loop
		  A <= STD_LOGIC_VECTOR(to_signed(i, 32));
			for j in -50 to 50 loop	
            	B <= STD_LOGIC_VECTOR(to_signed(j, 32));	
--AND Test
				ALUOp <= "0000";
				wait for 10ns;
				assert(R = (A AND B)) report "AND ERROR";
				wait for 10ns;
--OR Test
				ALUOp <= "0001";
				wait for 10ns;
				assert(R = (A OR B)) report "OR ERROR";
				wait for 10ns;
--XOR Test
				ALUOp <= "0010";
				wait for 10ns;
				assert(R = (A XOR B)) report "XOR ERROR";
				wait for 10ns;
--NOR Test
				ALUOp <= "0011";
				wait for 10ns;
				assert(R = (A NOR B)) report "NOR ERROR";
				wait for 10ns;

--ADD Signed Test
				ALUOp <= "0100";
				wait for 10ns;
				assert(R = STD_LOGIC_VECTOR(to_signed(i,32) + to_signed(j,32))) report "ADD SIGNED ERROR";
				wait for 10ns;
				
--ADD Unsigned Test
				ALUOp <= "0101";
				wait for 10ns;
				assert(R = STD_LOGIC_VECTOR(to_unsigned(i,32) + to_unsigned(j,32))) report "ADD UNSIGNED ERROR";
				wait for 10ns;
				
--SUB Signed Test
				ALUOp <= "0110";
				wait for 10ns;
				assert(R = (STD_LOGIC_VECTOR(to_signed(i,32) - to_signed(j,32)))) report "SUB SIGNED ERROR";
				wait for 10ns;
				
--SUB Unsigned Test
				ALUOp <= "0111";
				wait for 10ns;
				assert(R = (STD_LOGIC_VECTOR(to_unsigned(i,32) - to_unsigned(j,32)))) report "SUB UNSIGNED ERROR";
				wait for 10ns;
				
--Signed LT
				ALUOp <= "1010";
				wait for 10ns;
				if (to_signed(i,32) < to_signed(j,32)) then
					assert(R = "00000000000000000000000000000001") report "SIGNED LESS THAN ERROR";
				else
					assert(R = "00000000000000000000000000000000") report "SIGNED LESS THAN ERROR";
				end if;
				wait for 10ns;	
				
--Unsigned LT
				ALUOp <= "1011";
				wait for 10ns;
				if (to_unsigned(i,32) < to_unsigned(j,32)) then
					assert(R = "00000000000000000000000000000001") report "UNSIGNED LESS THAN ERROR";
				else
				    assert(R = "00000000000000000000000000000000") report "UNSIGNED LESS THAN ERROR";
				end if;
				wait for 10ns;
            end loop;
		end loop;		
		
		for m in -100 to 100 loop
		    A <= STD_LOGIC_VECTOR(to_signed(m, 32));
			for n in 0 to 31 loop
            	SHAMT <= STD_LOGIC_VECTOR(to_unsigned(n, 5));
            	wait for 10ns;
            	
--Shift Left Logical
				ALUOp <= "1100";
				wait for 10ns;
				assert(R = (STD_LOGIC_VECTOR(to_signed(m,32) sll n))) report "SHIFT LEFT LOGICAL ERROR";
				
--Shift Left Arithmatic (same as logical)
				ALUOp <= "1101";
				wait for 10ns;
				assert(R = (STD_LOGIC_VECTOR(shift_left(to_signed(m,32), n)))) report "SHIFT LEFT ARITHMATIC ERROR";
				
--Shift Right Logical
				ALUOp <= "1110";
				wait for 10ns;
				assert(R = (STD_LOGIC_VECTOR(to_signed(m,32) srl n))) report "SHIFT RIGHT LOGICAL ERROR";
				
--Shift Right Arithmatic	
				ALUOp <= "1111";
				wait for 10ns;
				assert(R = STD_LOGIC_VECTOR(shift_right(to_signed(m,32), n))) report "SHIFT RIGHT ARITHMATIC ERROR";							
			end loop;
		end loop;

    wait;
    end process;
end sim;