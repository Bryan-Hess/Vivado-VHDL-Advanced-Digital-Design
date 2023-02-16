library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cpu_tb is
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC
    );
end cpu_tb;

architecture Behavioral of cpu_tb is

    component CPU is
        port (
            Clock : IN STD_LOGIC;
            Reset : in STD_LOGIC;
            MemoryDataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            MemoryAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            MemoryDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            MemWrite : OUT STD_LOGIC
        );
        
    end component;
    component CPU_memory is
        port (
            Clk : IN STD_LOGIC;
            addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            dataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            MemWrite : IN STD_LOGIC;
            dataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    signal Address, DataIn, DataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal MemWrite : STD_LOGIC;
    
begin

    U_0 : CPU
    port map(
        Clock         => clk,
        Reset         => reset,
        MemoryDataIn  => DataOut,
        MemoryAddress => Address,
        MemoryDataOut => DataIn,
        MemWrite      => MemWrite
    );

    U_1 : CPU_memory
    port map(
        Clk      => clk,
        addr     => Address,
        dataIn   => DataIn,
        MemWrite => MemWrite,
        dataOut  => DataOut
    );
end Behavioral;