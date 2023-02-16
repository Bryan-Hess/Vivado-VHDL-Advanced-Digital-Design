library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is
    --Build an enumerated type for the state machine
    type state_type is (
        reset, InF, RegFet,             --IF/ID for All Types
        
        RExe, RComp,                    --R Type EXE/MEM/WB
        IExe, IComp,                    --I Type EXE/MEM/WB
        
        JComp,                          --J Type EXE/MEM/WB
        BExe, BBuffer, BComp,           --Branch EXE/MEM/WB
        LinkExe, LinkBuffer, LinkComp,  --BLTZAL EXE/MEM/WB
        
        LoadExe, LoadBuffer, LoadComp,  --LD EXE/MEM/WB
        StoreExe, StoreComp,            --SD EXE/MEM/WB
        
        MComp,                          --Mult EXE/MEM/WB
        LeadOnesComp                    --CLO EXE/MEM/WB
    );

    --Register to hold the current state
	signal pr_state, nx_state : state_type;
	--Need signal for immediate or some tests won't pass
    signal Func : STD_LOGIC_VECTOR(5 DOWNTO 0);
begin
    Func <= Immediate(5 DOWNTO 0);

    process (RST, CLK)
    begin
        if RST = '1' then
            pr_state <= reset;
        elsif (CLK'event and CLK = '1') then
            pr_state <= nx_state;
        end if;
    end process;

    process (Op, pr_state, Func)
    begin
        case pr_state is
            when reset =>                       --Reset from RegFile
                nx_state <= InF;
            when InF =>                         --Instruction Fetch
                nx_state <= RegFet;
                
            when RegFet =>                      --Decode logic for instruction OP
                ----------000000 Op Code----------
                if (Op = "000000") then
                    ----------J Type----------
                    if (Func = "001000") then                                                   --JR
                        nx_state <= JComp;
                    ----------Mult----------
                    elsif (Func = "011001" or Func = "010000" or Func = "010010") then          --MULTU MFHI MFLO 
                        nx_state <= MComp;
                    ----------R Type----------
                    else                                                                        --ADDU AND SUB SRA SLLV SLL
                        nx_state <= RExe;
                    end if;
                
                ----------I Type----------
                elsif (Op = "001000" or Op = "001101" or Op = "001010" or Op = "001111") then   --ADDI ORI SLTI LUI
                    nx_state <= IExe;
                    
                ----------J Type----------   
                elsif (Op = "000101") then                                                      --BNE
                    nx_state <= BExe;
                elsif (Op = "000001") then                                                      --BLTZAL
                    nx_state <= LinkExe;
                elsif (Op = "000010") then                                                      --J
                    nx_state <= JComp;
                    
                ----------Mem Type----------
                elsif (Op = "100011" or Op = "100001" or Op = "100000") then                    --LW LH LB
                    nx_state <= LoadExe;
                elsif (Op = "101011") then                                                      --SW
                    nx_state <= StoreExe;
                ----------Special----------    
                elsif (Op = "011100" and Func = "100001") then                                  --CLO
                    nx_state <= LeadOnesComp;
                end if;
                
            when RExe =>                      --R Execution
                nx_state <= RComp;
            when RComp =>                     --R Completion
                nx_state <= InF;
                
            when IExe =>                      --I Execution
                nx_state <= IComp;
            when IComp =>                     --I Completion
                nx_state <= InF;
               
            when JComp =>                     --J Completion
                nx_state <= InF;    
            when BExe =>                      --Branch Execution
                nx_state <= BBuffer;
            when BBuffer =>                   --Branch Processing
                nx_state <= BComp;
            when BComp =>                     --Branch Completion
                nx_state <= InF;
            when LinkExe =>                   --BLTZAL Execution
                nx_state <= LinkBuffer;
            when LinkBuffer =>                --BLTZAL Processing
                nx_state <= LinkComp;
            when LinkComp =>                  --BLTZAL Completion
                nx_state <= InF;
                
            when LoadExe =>                   --LD Execution
                nx_state <= LoadBuffer;
            when LoadBuffer =>                --LD Processing
                nx_state <= LoadComp;
            when LoadComp =>                  --LD Completion
                nx_state <= InF;
            when StoreExe =>                  --SW Execution
                nx_state <= StoreComp;
            when StoreComp =>                 --SW Completion
                nx_state <= InF;
                
            when MComp =>                     --Multiplication Completion
                nx_state <= InF;
                
            when LeadOnesComp =>              --CLO Completion
                nx_state <= InF;    
        end case;
    end process;

    --Section 3: Output Function
    process (Op, pr_state)
    begin
        case pr_state is
        ---------------Signal Definitions-------------------
                --Left Side Controls
        --PCWrite           Program Counter
        --IorD              00:PC			    01:ALUOut
        --MemWrite          Memory Write
        --MemtoReg          00:ALUOut           01:MemDataReg   10:Mult High/Low    11:LeadingOnes
        --IRWrite           Instruction Register
        
            --Right Side Controls
        --PCSource         00:ALUResult		   01:ALUOut       10:ShiftLeft		
        --ALUOp            SEE ALU CONTROL FOR MAPPING 
        --ALUSrcB          00:RegB			    01:4           10:Sign Extended     11:ShiftLeft 
        --ALUSrcA          00:PC			    01:RegA
        --RegWrite         RegFile 
        --RegDst           00:Instrustion20-16	01:Instrustion15-0 
        
            --Mem And HighLow Controls
        --ResizeSel        00:HalfWord(Upper)   01:Word        10:HalfWord(Lower)  11:Byte(Lower) 
        --HighOrLow        00:High Register     01:Low Register   
        
            --Enables For Registers
        --AEn           
        --BEn           
        --ALUOutEn          
        --MemEn             
        --MultHighEn        
        --MultLowEn         
        ----------------------------------------------------
        
            when reset =>
                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "00";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '1'; 
                
            when InF => --Instruction Fetch
            
                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '1';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 

            when RegFet => --Instruction Decode & Registers Fetch

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "00";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '1';           
                BEn <= '1';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 

            when RExe => --R-Type Execution

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "00";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                				
            when RComp => --R-Type Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '1';
                RegDst <= "01";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                				
            when IExe => --I-Type Execution

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "10";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                			
            when IComp => --I-Type Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '1';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                
            when JComp => --Jump Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                if (Op = "000000") then --JR
                    ALUOp <= Op;
                else                    --J
                    ALUOp <= "101011";
                end if;
                ALUSrcB <= "11";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
            when BExe => --Branch Execution

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "101011";
                ALUSrcB <= "11";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
	
            when BBuffer => --Branch Processing
                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "00";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                	
            when BComp => --Branch Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                if (Zero = '0') then    --If !=
                    PCSource <= "01";
                else                    --If ==
                    PCSource <= "00";
                end if;	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
			
            when LinkExe => --Link Execution (Store PC<<2 in ALUOut)

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                		
            when LinkBuffer => --Link Processing

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "00";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0';
                
            when LinkComp => --Link Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                if (Zero = '0') then    --Jump 
                    PCSource <= "00";
                    RegWrite  <= '1';
                else                    --No Jump (Use ALU)
                    PCSource <= "01";
                    RegWrite  <= '0';
                end if;	
                ALUOp <= "101011";
                ALUSrcB <= "11";
                ALUSrcA <= "00";
                RegDst <= "10";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
			
            when LoadExe => --Load Memory Address Computation

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "10";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                
            when LoadBuffer => --Load Memory Address Access

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "01";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= Op;
                ALUSrcB <= "00";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                if (Op = "100011") then     --LW
                    ResizeSel <= "01";
                elsif (Op = "100001") then  --LH
                    ResizeSel <= "10";
                elsif (Op = "100000") then  --LB
                    ResizeSel <= "11";
                end if;
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '1';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
				
            when LoadComp => --Load Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "01";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '1';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                			
            when StoreExe => --Store Memory Address Computation

                    --Left Side Controls
                PCWrite <= '0';
                IorD <= "01";
                MemWrite <= '0';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "10";
                ALUSrcA <= "01";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '1';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
			
            when StoreComp => --Store Completion
                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "01";
                MemWrite <= '1';
                MemtoReg <= "00";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '0';
                RegDst <= "00";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 

            when MComp => --Multiplication Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';

                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegDst <= "01";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                ResetAllReg <= '0';
                if (Func = "011001") then       --MULTU
                    MemtoReg <= "00";
                    HighOrLow <= "00";
                    RegWrite <= '0';
                    MultHighEn <= '1';
                    MultLowEn <= '1';
                elsif (Func = "010000") then    --MFHI
                    MemtoReg <= "10";
                    HighOrLow <= "00";
                    RegWrite <= '1';
                    MultHighEn <= '0';
                    MultLowEn <= '0';
                elsif (Func = "010010") then    --MFLO
                    MemtoReg <= "10";
                    HighOrLow <= "01";
                    RegWrite <= '1';
                    MultHighEn <= '0';
                    MultLowEn <= '0';
                end if;
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';                     
                
                --Global Reset
                ResetAllReg <= '0'; 
			
            when LeadOnesComp => --CLO Completion

                    --Left Side Controls
                PCWrite <= '1';
                IorD <= "00";
                MemWrite <= '0';
                MemtoReg <= "11";
                IRWrite <= '0';
                
                    --Right Side Controls
                PCSource <= "00";	
                ALUOp <= "001000";
                ALUSrcB <= "01";
                ALUSrcA <= "00";
                RegWrite <= '1';
                RegDst <= "01";
                
                    --Mem And HighLow Controls
                ResizeSel <= "00";
                HighOrLow <= "00";  
                
                    --Enables For Registers
                AEn <= '0';           
                BEn <= '0';           
                ALUOutEn <= '0';          
                MemEn <= '0';             
                MultHighEn <= '0';        
                MultLowEn <= '0';
                
                --Global Reset
                ResetAllReg <= '0'; 
                
                ----SELECTOR
                PCSource           <= "00";--00:ALUResult		01:ALUOut		10:ShiftLeft2		11:
                IorD          <= "00";--00:PC			    01:ALUOut		10:					11:
                RegDst       <= "01";--00:Inst20-16		01:Inst15-0		10:					11:
                MemtoReg      <= "11";--00:ALUOut		    01:MemDataReg	10:Mtplictn Hi/Lo   11:LeadingOnes
                HighOrLow      <= "00";--00:High Register    01:Low Register 10:					11:
                ALUSrcA         <= "00";--00:PC			    01:RegA			10:					11:
                ALUSrcB         <= "01";--00:RegB			    01:4 (CONSTANT)	10:SignExtended		11:ShiftLeft2
                ResizeSel <= "00";--00:HalfWord(Upper)   01:Word(Ori)    10:HalfWord(Lower)  11:Byte(Lower)
                ALUOp        <= "001000";--Use ALU::ADD by pretending to be addi
                ----ENABLER
                PCWrite       <= '1';--Program Counter
                MemWrite <= '0';--Memory :: Write
                IRWrite <= '0';--Instruction Register
                MemEn  <= '0';--Memory Data Register
                RegWrite      <= '1';--Registers
                AEn        <= '0';--A
                BEn        <= '0';--B
                ALUOutEn   <= '0';--ALUOut
                MultHighEn       <= '0';--High Bits from Multiplication
                MultLowEn       <= '0';--Low Bits from Multiplication
                --GLOBAL RESET
                ResetAllReg <= '0';
        end case;

    end process;

end Behavioral;