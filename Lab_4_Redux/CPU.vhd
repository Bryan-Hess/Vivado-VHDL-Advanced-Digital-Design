library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CPU is
    port (
        Clock : IN STD_LOGIC;
        Reset : in STD_LOGIC;
        MemoryDataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemoryAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemoryDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemWrite : OUT STD_LOGIC
    );
end CPU;

architecture Behavioral of CPU is
    
    --A. ALU
    component ALU is
        port (
			A: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			B: IN 	STD_LOGIC_VECTOR (31 DOWNTO 0);
			ALUOp: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			SHAMT: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			shftCont : IN STD_LOGIC;
			R: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			Zero: OUT STD_LOGIC
        );
    end component;
    
    --B. ALU Control
    component ALUControl is
        port (
            Op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Func : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ALUOp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            SHAMT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            shftCont : OUT STD_LOGIC
        );
    end component;
    
    --C. Regsiter File
    component RegFile is
        generic (
            n : positive := 32
        );
        port (
            CLK : IN  STD_LOGIC;
            RST : IN STD_LOGIC;
            RegWrite : IN  STD_LOGIC;
            ReadReg1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            ReadReg2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            WriteReg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            WriteData : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            ReadData1 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            ReadData2 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
        );
    end component;
    
    --D. Sign-extend, Shift Left
    component SignExtender is
        port (
            D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            OP : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            SingExtended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            LeftShifted : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    component LeftShifter is
        port (
            RS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            RT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            Immmediate : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Shifted : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    --E. Registers, Muxes:
    component Reg is
        generic (
            n : positive := 64
        );
        Port (
            CLK : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            EN : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
        );
    end component;
    
    component InstructionRegister is
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
    end component;
    
    component Mux is
        generic (
            n : positive := 32
        );
        port (
            Sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            D0 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            D2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            D3 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    end component;
    
    --F. Multiplier
    component Multiplier is
        port (
            A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            High : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Low : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    --G. Control Unit
    component ControlUnit is
        port (
            CLK : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            Op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Immediate : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Zero : IN STD_LOGIC;        
            
            --Left Side Controls
            PCWrite : OUT STD_LOGIC;
            IorD : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            MemWrite : OUT STD_LOGIC;
            MemtoReg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            IRWrite : OUT STD_LOGIC;
            
            --Right Side Controls
            PCSource : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            ALUOp : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            ALUSrcB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            ALUSrcA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegWrite : OUT STD_LOGIC;
            RegDst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            
            --Mem And HighLow Controls
            ResizeSel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            HighOrLow : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);    
            
            --Enables For Registers
            AEn : OUT STD_LOGIC;
            BEn : OUT STD_LOGIC;
            ALUOutEn : OUT STD_LOGIC;
            MemEn : OUT STD_LOGIC;
            MultHighEn : OUT STD_LOGIC;
            MultLowEn : OUT STD_LOGIC;
            
            --Global Reset
            ResetAllReg : OUT STD_LOGIC
        );
    end component;
    
    component LeadingOnesCounter is
        port (
            D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Count : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    component Resizer is
        port (
            D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    --Signal Declaration (Apprear as close to componant declarations as possible)
    signal ALUOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ALUZeroOut : STD_LOGIC;
    signal ALUOp : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal SHAMT : STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal shftCont : STD_LOGIC;
    
    signal ReadData1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ReadData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal SignExtenderOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal SignExtenderShiftedOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal LeftShifterOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal PCRegOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal MemDataRegOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal RegAOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal RegBOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ALUOutRegOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal HighRegOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal LowRegOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal IROpOut : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal IRRSOut : STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal IRRTOut : STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal IRAddressImmediate : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal AddressMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal WriteReg : STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal HighLowOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal WriteData : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ALUMuxAOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ALUMuxBOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal PCMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal HighOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal LowOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal PCWrite : STD_LOGIC;
    signal IorD : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal MemtoReg : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal IRWrite : STD_LOGIC;
    signal PCSource : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal ALUOpControlUnit : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal ALUSrcB : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal ALUSrcA : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal RegWrite : STD_LOGIC;
    signal RegDst : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal ResizeSel : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal HighOrLow : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal AEn : STD_LOGIC;
    signal BEn : STD_LOGIC;
    signal ALUOutEn : STD_LOGIC;
    signal MemEn : STD_LOGIC;
    signal MultHighEn : STD_LOGIC;
    signal MultLowEn : STD_LOGIC;
    signal ResetAllReg : STD_LOGIC;
    
    signal LeadingOnesOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ResizeOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin
    --Outputs for CPU linked to signals
    MemoryAddress    <= AddressMuxOut;
    MemoryDataOut <= RegBOut;
    
    --Componants
    ArithLogUnit : ALU
    port map(
        ALUOp => ALUOp,
        SHAMT => SHAMT,
        shftCont => shftCont,
        A => ALUMuxAOut,
        B => ALUMuxBOut,
        R => ALUOut,
        Zero => ALUZeroOut
    );
    
    ALUCont : ALUControl
    port map(
        Op => ALUOpControlUnit,
        Func => IRAddressImmediate,
        ALUOp => ALUOp,
        SHAMT => SHAMT,
        shftCont => shftCont
    );
    
    RegisterFile : RegFile
    port map(
        CLK => Clock,
        RST => ResetAllReg,
        RegWrite => RegWrite,
        ReadReg1 => IRRSOut,
        ReadReg2 => IRRTOut,
        WriteReg => WriteReg,
        WriteData => WriteData,
        ReadData1 => ReadData1,
        ReadData2 => ReadData2
    );

    SignExtend : SignExtender
    port map(
        D => IRAddressImmediate,
        OP => IROpOut,
        SingExtended => SignExtenderOut,
        LeftShifted => SignExtenderShiftedOut
    );

    LeftShift : LeftShifter
    port map(
        RS => IRRSOut,
        RT => IRRTOut,
        Immmediate => IRAddressImmediate,
        PC => PCRegOut,
        Shifted => LeftShifterOut
    );

    PCReg : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => PCMuxOut,
        EN => PCWrite,
        RST => ResetAllReg,
        Q => PCRegOut
    );
    
    MemDataReg : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => ResizeOut,
        EN => MemEn,
        RST => ResetAllReg,
        Q => MemDataRegOut
    );
    
    RegA : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => ReadData1,
        RST => ResetAllReg,
        EN => AEn,
        Q => RegAOut
    );
    
    RegB : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => ReadData2,
        RST => ResetAllReg,
        EN => BEn,
        Q => RegBOut
    );
    
    ALUOutReg : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => ALUOut,
        RST => ResetAllReg,
        EN => ALUOutEn,
        Q => ALUOutRegOut
    );
    
    HighReg : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => HighOut,
        RST => ResetAllReg,
        EN => MultHighEn,
        Q => HighRegOut
    );
    
    LowReg : Reg
    generic map(32)
    port map(
        CLK => Clock,
        D => LowOut,
        RST => ResetAllReg,
        EN => MultLowEn,
        Q => LowRegOut
    );
    
    IR : InstructionRegister
    port map(
        CLK => Clock,
        RST => ResetAllReg,
        EN => IRWrite,
        Instruction => MemoryDataIn,
        OP => IROpOut,
        RS => IRRSOut,
        RT => IRRTOut,
        Immmediate => IRAddressImmediate
    );
    
    CMPMux : Mux
    generic map(32)
    port map(
        Sel => IorD,
        D0 => PCRegOut,
        D1 => ALUOutRegOut,
        D2 => X"00000000",
        D3 => X"00000000",
        Q => AddressMuxOut
    );
    
    WrtRegMux : Mux
    generic map(5)
    port map(
        Sel => RegDst,
        D0 => IRRTOut,
        D1 => IRAddressImmediate(15 DOWNTO 11),
        D2 => "11111",
        D3 => "00000",
        Q => WriteReg
    );
    
    WrtDataMux : Mux
    generic map(32)
    port map(
        Sel => MemtoReg,
        D0 => ALUOutRegOut,
        D1 => MemDataRegOut,
        D2 => HighLowOut,
        D3 => LeadingOnesOut,
        Q => WriteData
    );
    
    HighLowMux : Mux
    generic map(32)
    port map(
        Sel => HighOrLow,
        D0 => HighRegOut,
        D1 => LowRegOut,
        D2 => X"00000000",
        D3 => X"00000000",
        Q => HighLowOut
    );
    
    ALUAMux : Mux
    generic map(32)
    port map(
        Sel => ALUSrcA,
        D0 => PCRegOut,
        D1 => RegAOut,
        D2 => X"00000000",
        D3 => X"00000000",
        Q => ALUMuxAOut
    );
    
    ALUBMux : Mux
    generic map(32)
    port map(
        Sel => ALUSrcB,
        D0 => RegBOut,
        D1 => X"00000004",
        D2 => SignExtenderOut,
        D3 => SignExtenderShiftedOut,
        Q => ALUMuxBOut
    );
    
    PCMux : Mux
    generic map(32)
    port map(
        Sel => PCSource,
        D0 => ALUOut,
        D1 => ALUOutRegOut,
        D2 => LeftShifterOut,
        D3 => X"00000000",
        Q => PCMuxOut
    );
    
    Mult : Multiplier
    port map(
        A => RegAOut,
        B => RegBOut,
        High => HighOut,
        Low => LowOut
    );
        
    ContUnit : ControlUnit
    port map(
        CLK => Clock,
        RST => Reset,
        Op => IROpOut,
        Immediate => IRAddressImmediate,
        Zero => ALUZeroOut,      
            
            --Left Side Controls
        PCWrite => PCWrite,
        IorD => IorD,
        MemWrite => MemWrite,
        MemtoReg => MemtoReg,
        IRWrite => IRWrite,
            
            --Right Side Controls
        PCSource => PCSource,
        ALUOp => ALUOpControlUnit,
        ALUSrcB => ALUSrcB,
        ALUSrcA => ALUSrcA,
        RegWrite => RegWrite,
        RegDst => RegDst,
            
            --Mem And HighLow Controls
        ResizeSel => ResizeSel,
        HighOrLow => HighOrLow,    
            
            --Enables For Registers
        AEn => AEn,
        BEn => BEn,
        ALUOutEn => ALUOutEn,
        MemEn => MemEn,
        MultHighEn => MultHighEn,
        MultLowEn => MultLowEn,
            
            --Global Reset
        ResetAllReg => ResetAllReg
    );
    
    LeadingOnes : LeadingOnesCounter
    port map(
        D => RegAOut,
        Count => LeadingOnesOut
    );
    Resiz : Resizer
    port map(
        D => MemoryDataIn,
        Selector => ResizeSel,
        Q => ResizeOut
    );
end Behavioral;