library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdderSubtractor is
	port (
		A    : IN  STD_LOGIC; --Value 1
		B    : IN  STD_LOGIC; --Value 2
		Cin  : IN  STD_LOGIC; --Carry in
		Cout : OUT STD_LOGIC; --Carry out
		S    : OUT STD_LOGIC  --Sum
	);
end FullAdderSubtractor;

architecture dataflow of FullAdderSubtractor is 
begin
	S <= A XOR B XOR Cin;
	Cout <= (A and B) OR (A and Cin) OR (B and Cin);
end dataflow;
