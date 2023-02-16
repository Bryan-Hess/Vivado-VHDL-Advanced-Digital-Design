library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControllUnit is
	generic(
		n: positive := 32
	);
	port(
		-----INPUT FROM THE INTERNAL PROCESSOR
		CLK: in std_logic; -- Internal input of clock
		-----INPUT FROM USER (R6EAD FROM REGMAP REGISTERS)
		A: in std_logic_vector(n-1 downto 0); --User input of multiplier (Use this ONLY ONCE!)
		B: in std_logic_vector(n-1 downto 0); -- User input of multiplicand (Use this ONLY ONCE!)
		RST: in std_logic; -- User input of reset 
		-----INPUT FROM OTHER BLOCK MODULES
		done : in std_logic;
		multiplierIn: in std_logic_vector(n-1 downto 0); -- Shifted Multiplier from Multiplier Shifter (Use this to determine if copy or no copy)
		multiplicandIn: in std_logic_vector((n*2)-1 downto 0); -- Shifted Multiplicand from Multiplicand Shifter (Use this to repass to the multiplicand shifter)
		--i_vec_count: in std_logic_vector(n-1 downto 0); -- Number of count in vector form (Use this to determine if 32 repetations are reached)
		-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
		multiplierOut: out std_logic_vector(n-1 downto 0); -- Unshifted Multiplier to Multiplier Shifter
		multiplicandOut: out std_logic_vector(n*2-1 downto 0); -- Unshifted Multiplicand to Multiplicand Shifter
		-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
		EN : out std_logic; -- Toggle switch for Multiplier Shifter Enable
		SHFT: out std_logic; -- Toggle switch for Mutiplicand Shifter Shift

		o_l_productEnable: out std_logic; -- Toggle switch for Product
		o_l_counterEnable: out std_logic -- Toggle switch for Counter
	);
end ControllUnit;

architecture Behavioral of ControllUnit is
	type t_sta is 
		(sta_s,sta_1,sta_1a,sta_23,sta_d);
	signal s_sta_prev,s_sta_next: t_sta := sta_s;

begin

	--FSM Registers
	process(RST, CLK)
	begin
		if RST = '1' then
			s_sta_prev <= sta_s; ---State reset
		elsif (CLK'event and CLK = '0') then
			s_sta_prev <= s_sta_next;
		end if;
	end process;


	--FSM Implimentation
	process(multiplierIn,done,s_sta_prev)
	begin
		case s_sta_prev is
			when sta_s =>
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				multiplierOut <= A; -- Unshifted Multiplier to Multiplier Shifter
				multiplicandOut <= (std_logic_vector(to_unsigned(0,n)) & B); -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				EN   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- because 1a will use multiplier(0)
				SHFT    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)      
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
				s_sta_next <= sta_1;
			when sta_1 =>
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				multiplierOut <= multiplierIn; -- Unshifted Multiplier to Multiplier Shifter
				multiplicandOut <= multiplicandIn; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				EN   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)
				SHFT    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product -- because place the result in product register
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
				if multiplierIn(0) = '1' then
					s_sta_next <= sta_1a;
				else
					s_sta_next <= sta_23;
				end if; 
			when sta_1a =>
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				multiplierOut <= multiplierIn; -- Unshifted Multiplier to Multiplier Shifter
				multiplicandOut <= multiplicandIn; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				EN   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- shift
				SHFT    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_productEnable 	<=	'1'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
				s_sta_next <= sta_23;
			when sta_23 =>
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				multiplierOut <= multiplierIn; -- Unshifted Multiplier to Multiplier Shifter
				multiplicandOut <= multiplicandIn; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				EN   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- shift
				SHFT    <=	'1'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'1'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
				if done = '0'  then
					s_sta_next <= sta_1;
				else
					s_sta_next <= sta_d;
				end if;
			when sta_d =>
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				multiplierOut <= multiplierIn; -- Unshifted Multiplier to Multiplier Shifter
				multiplicandOut <= multiplicandIn; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				EN   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- shift
				SHFT    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
		end case;
	end process;



end Behavioral;
