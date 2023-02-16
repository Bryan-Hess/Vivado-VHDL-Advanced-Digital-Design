library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
	Port(
			A: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			B: IN 	STD_LOGIC_VECTOR (31 DOWNTO 0);	
			ALUOp: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			SHAMT: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			R: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			Zero: OUT STD_LOGIC;
			Overflow: OUT STD_LOGIC
		);
end ALU;

architecture Behavioral of ALU is
    --Logical Unit Componant
    component LogicalUnit is
    Port( 
        A:  STD_LOGIC_VECTOR (31 DOWNTO 0);
        B: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        ALUOp:  IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        R:   OUT STD_LOGIC_VECTOR (31 DOWNTO 0)   
    );
    end component;
    
    --Arith Unit Componant
	component Arith_Unit IS
		GENERIC (
	     	n       : positive := 32
	     		);
	   	PORT( 
			    A       : IN     std_logic_vector (n-1 DOWNTO 0);
			    B       : IN     std_logic_vector (n-1 DOWNTO 0);
			    C_op    : IN     std_logic_vector (1 DOWNTO 0);
			    CO      : OUT    std_logic;
			    OFL     : OUT    std_logic;
			    S       : OUT    std_logic_vector (n-1 DOWNTO 0);
			    Z       : OUT    std_logic
	   	);
	end component ;

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
    
    --Shifter Unit Componant
    component ShifterUnit is
    Port( 
        A:  IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        SHAMT:  IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        ALUOp:  IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        R:  OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
	end component;
    
    signal LogR, ArithR, CompR, ShiftR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ArithCarry : std_logic;
begin

    U1: LogicalUnit port map (
            A => A,
            B => B,
            ALUOp => ALUOp(1 DOWNTO 0),
            R => LogR
        );
            
    U2: Arith_Unit port map (
            A => A,
            B => B,
            C_op => ALUOp(1 DOWNTO 0),
            CO => ArithCarry,
            OFL => Overflow,
            S => ArithR,
            Z => Zero
        );
            
    U3: ComparatorUnit port map (
            A_31 => A(31),
            B_31 => B(31),
            S_31 => ArithR(31),
            CO => ArithCarry,
            ALUOp => ALUOp(1 DOWNTO 0),
            R => CompR
        );
            
    U4: ShifterUnit port map (
            A => A,
            SHAMT => SHAMT,
            ALUOp => ALUOp(1 DOWNTO 0),
            R => ShiftR
        );
    
    --Muxing Each R with first two bits of ALUOp
    WITH ALUOp(3 DOWNTO 2) SELECT
            R <= LogR WHEN "00",         --Logical Unit
            ArithR WHEN "01",            --Arithmatic Unit
            CompR WHEN "10",             --Comparator Unit
            ShiftR WHEN "11",            --Shifter Unit
            X"FFFFFFFF" WHEN others;     --Defaults to all 1s if ERROR


end Behavioral;
