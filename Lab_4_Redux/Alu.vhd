library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
    port (
        A: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		B: IN 	STD_LOGIC_VECTOR (31 DOWNTO 0);
		ALUOp: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		SHAMT: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		shftCont : IN STD_LOGIC;
		R: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		Zero: OUT STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    signal R_Signal : STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    --Zero flag 
    Zero <= '1' when R_Signal = x"00000000" else '0';
    R <= R_Signal;
    
    process (A, B, ALUOp, shftCont, SHAMT)
    begin
    
        case(ALUOp) is
        --Logical Unit
            when "0000" => --AND
                R_Signal <= A AND B;
            when "0001" => --OR
                R_Signal <= A OR B;
            when "0010" => --XOR
                R_Signal <= A XOR B;
            when "0011" => --NOR
                R_Signal <= A NOR B;
            
        --Arithmatic Unit
            when "0100" => --ADD
                R_Signal <= STD_LOGIC_VECTOR(SIGNED(A) + SIGNED(B));
            when "0101" => --ADDU
                R_Signal <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B));
            when "0110" => --SUB
                R_Signal <= STD_LOGIC_VECTOR(SIGNED(A) - SIGNED(B));
            when "0111" => --SUBU
                R_Signal <= STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B));
            
        --Comparator Unit
            when "1010" => --SLT
                if (shftCont = '0') then
                    if (SIGNED(A) < SIGNED(B)) then
                        R_Signal <= x"00000001";
                    else
                        R_Signal <= x"00000000";
                    end if;
                else
                    if (SIGNED(A) < to_signed(0, 32)) then
                        R_Signal <= x"00000001";
                    else
                        R_Signal <= x"00000000";
                    end if;
                end if;
            when "1011" => --SLTU
                if (UNSIGNED(A) < UNSIGNED(B)) then
                    R_Signal <= x"00000001";
                else
                    R_Signal <= x"00000000";
                end if;
            
        --Shifter Unit
            when "1100" => --SLL
                if (shftCont = '0') then
                    R_Signal <= STD_LOGIC_VECTOR(shift_left(UNSIGNED(A), to_integer(UNSIGNED(SHAMT))));
                else
                    R_Signal <= STD_LOGIC_VECTOR(shift_left(UNSIGNED(B), to_integer(UNSIGNED(SHAMT))));
                end if;
            when "1101" => --SLA
                if (shftCont = '0') then
                    R_Signal <= STD_LOGIC_VECTOR(shift_left(SIGNED(A), to_integer(UNSIGNED(SHAMT))));
                else
                    R_Signal <= STD_LOGIC_VECTOR(shift_left(SIGNED(B), to_integer(UNSIGNED(SHAMT))));
                end if;
            when "1110" => --SRL
                if (shftCont = '0') then
                    R_Signal <= STD_LOGIC_VECTOR(shift_right(UNSIGNED(A), to_integer(UNSIGNED(SHAMT))));
                else
                    R_Signal <= STD_LOGIC_VECTOR(shift_right(UNSIGNED(B), to_integer(UNSIGNED(SHAMT))));
                end if;
            when "1111" => --SRA
                if (shftCont = '0') then
                    R_Signal <= STD_LOGIC_VECTOR(shift_right(SIGNED(A), to_integer(UNSIGNED(SHAMT))));
                else
                    R_Signal <= STD_LOGIC_VECTOR(shift_right(SIGNED(B), to_integer(UNSIGNED(SHAMT))));
                end if;
            when "1000" => --SLLV
                if (shftCont = '0') then
                    R_Signal <= STD_LOGIC_VECTOR(shift_left(UNSIGNED(A), to_integer(UNSIGNED(B))));
                else
                    R_Signal <= STD_LOGIC_VECTOR(shift_left(UNSIGNED(B), to_integer(UNSIGNED(A))));
                end if;
            
        --Extra Controls
            when "1001" => --HOLD (Passes value through ALU wiht not OP)
                if (shftCont = '0') then
                    R_Signal <= A;
                else
                    R_Signal <= B;
                end if;

            when others => --When Invalid Signal
            R_Signal <= x"00000000";
        end case;
    end process;
end Behavioral;