library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity InstructionRegister is
	port (
		CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OP : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		RS : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		Immmediate : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
end InstructionRegister;

architecture Behavioral of InstructionRegister is
	component Reg is
		generic (
			n : positive := 64
		);
        Port (
            CLK: IN STD_LOGIC;
            D: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            EN: IN STD_LOGIC;
            RST: IN STD_LOGIC;
            Q: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
        );
	end component;
begin
	l_cmp_reg3 : Reg
	generic map(6)
	        port map (
            CLK => CLK,
            D => Instruction(31 DOWNTO 26),
            EN => EN,
            RST => RST,
            Q => OP
         );  

	l_cmp_reg2 : Reg
	generic map(5)
	        port map (
            CLK => CLK,
            D => Instruction(25 DOWNTO 21),
            EN => EN,
            RST => RST,
            Q => RS
         ); 


	l_cmp_reg1 : Reg
	generic map(5)
	        port map (
            CLK => CLK,
            D => Instruction(20 DOWNTO 16),
            EN => EN,
            RST => RST,
            Q => RT
         ); 


	l_cmp_reg0 : Reg
	generic map(16)
	        port map (
            CLK => CLK,
            D => Instruction(15 DOWNTO 0),
            EN => EN,
            RST => RST,
            Q => Immmediate
         ); 

end Behavioral;


