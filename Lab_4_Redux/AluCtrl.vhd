library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ALUControl is
    port (
        Op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        Func : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALUOp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        SHAMT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        shftCont : OUT STD_LOGIC
    );
end ALUControl;

architecture Behavioral of ALUControl is
begin
    process (Op, Func(5 DOWNTO 0))
    begin
        SHAMT        <= "00000";
        shftCont <= '0';
        
        case Op is 
            ----------R Type----------
            when "000000" =>
                case Func(5 DOWNTO 0) is 
                    when "100001" =>                                    --ADDU
                        ALUOp <= "0101"; --ADDU
                    when "100100" =>                                    --AND
                        ALUOp <= "0000"; --AND
                    when "000000" =>                                    --SLL
                        ALUOp <= "1100"; --SLL
                    when "000100" =>                                    --SLLV
                        ALUOp <= "1000"; --SLLV
                        shftCont <= '1';
                    when "000011" =>                                    --SRA
                        ALUOp <= "1111"; --SRA
                        SHAMT <= Func(10 DOWNTO 6);
                        shftCont <= '1';
                    when "100010" =>                                    --SUB
                        ALUOp <= "0110"; --SUB
                    when "001000" =>                                    --JR
                        ALUOp <= "1001"; --HOLD
                    when others =>
                    end case;
                    
            ----------I Type----------
            when "001000" =>                                            --ADDI
                ALUOp <= "0100"; --ADD                    
            when "001111" =>                                            --LUI
                ALUOp <= "1100"; --SLL
                shftCont <= '1';
                SHAMT <= "10000";
            when "001101" =>                                            --ORI
                ALUOp <= "0001"; --OR
            when "001010" =>                                             --SLTI
                ALUOp <= "1010"; --SLT
                
            ----------Others----------
            when "000010" =>                                             --J
                ALUOp <= "1001"; --HOLD            
            when "000001" =>                                             --BLTZAL 
                ALUOp <= "1010"; --SLT
                shftCont <= '1';
            when "101011" =>                                             --SW
                ALUOp <= "1001"; --HOLD
                shftCont <= '1';
            when others =>          
         end case;
        
    end process;

end Behavioral;