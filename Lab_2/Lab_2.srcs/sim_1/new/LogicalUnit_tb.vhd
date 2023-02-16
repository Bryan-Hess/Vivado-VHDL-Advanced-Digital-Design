library IEEE;library IEEE;
use IEEE.std_logic_1164.all;use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;use ieee.std_logic_arith.ALL;
use IEEE.math_real.ALL;

entity LogicalUnit_tb is
end LogicalUnit_tb;

architecture sim of LogicalUnit_tb is
    --Logical Unit Componant
    component LogicalUnit is
    Port ( 
        A :         in STD_LOGIC_VECTOR (31 downto 0);
        B :         in STD_LOGIC_VECTOR (31 downto 0);
        ALUOp:      in STD_LOGIC_VECTOR (1 downto 0);
        LogicalR: out STD_LOGIC_VECTOR (31 downto 0)   
        );
    end component;

    signal LogicalR_iter_expected, LogicalR_iter_produced : STD_LOGIC_VECTOR(31 downto 0);
    signal A_iter: STD_LOGIC_VECTOR(31 downto 0);
    signal B_iter: STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp_iter  : STD_LOGIC_VECTOR(1 downto 0);

begin
--Assigns ports to signals
    U: LogicalUnit port map(
        A => A_iter,
        B => B_iter,
        ALUOp => ALUOp_iter,
        LogicalR => LogicalR_iter_produced
    );
    process
    begin
        for i_iter in -2147483647 to 2147483647 loop
            for j_iter in -2147483647 to 2147483647 loop
                A_iter <= std_logic_vector(to_signed(i_iter, 32));
                B_iter <= std_logic_vector(to_signed(j_iter, 32));
                wait for 10ns;
    --------------------------------------------------------------------------AND
                ALUOp_iter <= "00";
                LogicalR_iter_expected<= A_iter AND B_iter;
                wait for 10ns;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "and error "         
                severity error;
    --------------------------------------------------------------------------OR
                ALUOp_iter <= "01";
                LogicalR_iter_expected<= A_iter OR B_iter;
                wait for 10ns;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "or error"             
                severity error;
    --------------------------------------------------------------------------XOR
                ALUOp_iter <= "10";
                LogicalR_iter_expected<= A_iter XOR B_iter;
                wait for 10ns;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "xor error"      
                severity error;
    --------------------------------------------------------------------------NOR
                ALUOp_iter <= "11";
                LogicalR_iter_expected<= A_iter NOR B_iter;
                wait for 10ns;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "or error at "   
                severity error;
    --------------------------------------------------------------------------
            end loop;
        end loop;
    wait;
    
    end process;


end sim;
