library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Multiplier is
    generic (
		n : positive := 64
	);
    port( 
        A: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        B: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        clk: IN STD_LOGIC;
        rst: IN STD_LOGIC;
        R: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
        done: OUT STD_LOGIC
     );
end Multiplier;

architecture Behavioral of Multiplier is

    --Build an enumerated type for the state machine
	type state_type is (Start, Test, Shift, Add, Fin);
	
	--Register to hold the current state
	signal pr_state, nx_state   : state_type;
	
	signal Load, RegEN, ShiftEN, Cout: std_logic;
	signal Multiplicand, RegIN, Product, Sum : STD_LOGIC_VECTOR(n-1 downto 0); 
	signal Multiplier : STD_LOGIC_VECTOR(31 downto 0);
	------------------------COUNTER ATTEMPT CODE----------------------------------------
--	signal countEn, countDone: std_logic;
--    signal cnt: STD_LOGIC_VECTOR(4 downto 0);
	------------------------COUNTER ATTEMPT CODE----------------------------------------
    component FullAdder is
        generic (
            n: positive := 64
        );
        Port(
            K     : IN  STD_LOGIC;
            A     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            B     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            Sum   : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            Cout  : OUT STD_LOGIC
        );
    end component;

    component Reg is
        Port (
            CLK: IN STD_LOGIC;
            D: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            EN: IN STD_LOGIC;
            RST: IN STD_LOGIC;
            Q: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
        );
    end component;

    component ShiftRegister is
        generic (
            n: positive := 64
        );
        port(
            CLK: IN STD_LOGIC;
            D: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            EN: IN STD_LOGIC;
            RST: IN STD_LOGIC;
            LOAD: IN STD_LOGIC;
            CON: IN STD_LOGIC; --0 = Shift Left,  1 = Shift Right
            Q: INOUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
        );
    end component;
------------------------COUNTER ATTEMPT CODE----------------------------------------
--    component Counter is
--        port(
--            EN: in std_logic;
--            RST: in std_logic;
--            count: out std_logic_vector(4 downto 0);
--            done: out std_logic
--        );
--    end component;
------------------------COUNTER ATTEMPT CODE----------------------------------------

begin

    FullAdd: FullAdder
        generic map (n => 64)
        port map(
            K => '0',
            A => Product,
            B => Multiplicand,
            Sum => Sum,
            Cout => Cout
        );
     
    Regist: Reg 
        port map(
            CLK => clk,
            D => RegIN,
            EN => RegEN,
            RST => rst,
            Q => Product
        );   
 
     LeftShifter: ShiftRegister
        generic map (n => 64)
        port map (
            CLK => clk,
            D(n-1 downto 32) => x"00000000",
            D(31 downto 0) => A,
            EN => ShiftEN,
            RST => rst,
            LOAD => Load,
            CON => '0',
            Q => Multiplicand
         );
            
    RighShifter: ShiftRegister
        generic map (n => 32)
        port map (
            CLK => clk,
            D => B,
            EN => ShiftEN,
            RST => rst,
            LOAD => Load, --might have to reverse Load
            CON => '1',
            Q => Multiplier
         );       

------------------------COUNTER ATTEMPT CODE----------------------------------------
--    fiveBitCounter: Counter 
--        port map(
--            EN => countEn,
--            RST => rst,
--           count => cnt,
--            done => countDone
--        );
------------------------COUNTER ATTEMPT CODE----------------------------------------

	--State advance logic
	process (clk, rst)
	   variable test : std_logic; 
	begin
		if rst = '1' then
			pr_state <= Start;
		elsif (clk'event AND clk = '1') then
		    pr_state <= nx_state;
		end if;
	end process;
	
	
	process(pr_state, Multiplier(0))
	   variable count : integer := 0;
	begin 	
        case pr_state is
            when Start =>
                R <= (others => '0');
                Load <= '1';
                ShiftEN <= '1';
                RegIN <= (others => '0');
                RegEN <= '1';
                count := 0;
                done <= '0';
                nx_state <= Test;
                
            when Test =>
------------------------COUNTER ATTEMPT CODE----------------------------------------               
--                countEn <= '0';
------------------------COUNTER ATTEMPT CODE----------------------------------------               
                Load <= '0';
                RegEN <= '0';
                ShiftEN <= '0';
                if Multiplier(0) = '1' then
                    nx_state <= Add;
                else
                    nx_state <= Shift;
                end if;
                
            when Add =>
                RegIN <= Sum;
                RegEN <= '1';
                nx_state <= Shift;
                
            when Shift =>
                RegEN <= '0';
                shiftEN <= '1';
--To attempt counter version, comment these next few lines out and uncomments the attempt code (runs 2 clock cycles slower                
                count := count + 1;
                if count<32 then 
                    nx_state <= Test;
                else 
                    nx_state <= Fin;
                end if;
                
 ------------------------COUNTER ATTEMPT CODE----------------------------------------               
--                countEn <= '1';
--                if countDone='0' then 
--                    nx_state <= Test;
--                else 
--                    nx_state <= Fin;
--                end if;
------------------------COUNTER ATTEMPT CODE----------------------------------------                
            when Fin =>
------------------------COUNTER ATTEMPT CODE----------------------------------------               
--                countEn <= '0';
------------------------COUNTER ATTEMPT CODE----------------------------------------  
                R <= product;
                done <= '1'; 
        end case;
	end process;
end Behavioral;
