library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MCCPUDave is
  port(clk:in std_logic; Overflow:out std_logic);
end MCCPUDave;

architecture struc of MCCPUDave is


  component ALU is
    port(a,b:in std_logic_vector(31 downto 0);
	  Oper:in std_logic_vector(3 downto 0);
	  Result:buffer std_logic_vector(31 downto 0);
	  Zero,Set,Overflow:buffer std_logic);
  end component;
  component ALUControl is
  port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
  end component;
  component AND2 is
  port (X,Y: in std_logic;Z:out std_logic);
  end component;
  component MCControl is
  port(clk:in std_logic; 
       Opcode:in std_logic_vector(5 downto 0); 
       PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemToReg,IRWrite,RegDst,RegWrite,ALUSrcA:out std_logic;
       ALUSrcB,ALUOp,PCSource:out std_logic_vector(1 downto 0));
  end component;
  component MCMemory is
	port(WriteData:in std_logic_vector(31 downto 0);
		   Address:in std_logic_vector(31 downto 0);
		   MemRead,MemWrite,CLK:in std_logic;
		   ReadData:out std_logic_vector(31 downto 0));
  end component;
  component MUX5 is
  port(x,y:in std_logic_vector (4 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(4 downto 0));
  end component;
  component Mux32 is
    Port ( 
    X,Y:in STD_LOGIC_VECTOR(31 downto 0);
    SEL:in STD_LOGIC;
    Z: out  STD_LOGIC_VECTOR(31 downto 0));
  end component;
  component MCMUX32x4 is
    Port ( D1:in STD_LOGIC_VECTOR(31 downto 0);
           D2:in STD_LOGIC_VECTOR(31 downto 0);
           D3:in STD_LOGIC_VECTOR(31 downto 0);
           D4:in STD_LOGIC_VECTOR(31 downto 0);
           SEL:in STD_LOGIC_VECTOR(1 downto 0);
           DOUT : out  STD_LOGIC_VECTOR(31 downto 0));
  end component;
  component MCMUX32x3 is
    Port ( D1:in STD_LOGIC_VECTOR(31 downto 0);
           D2:in STD_LOGIC_VECTOR(31 downto 0);
           D3:in STD_LOGIC_VECTOR(31 downto 0);
           SEL:in STD_LOGIC_VECTOR(1 downto 0);
           DOUT : out  STD_LOGIC_VECTOR(31 downto 0));
  end component;
  component MCRegisters is
  port (CLK,RegWrite:in STD_LOGIC;
       RR1,RR2,WR:in STD_LOGIC_VECTOR (4 downto 0); 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD1,RD2:out STD_LOGIC_VECTOR (31 downto 0));
  end component;
  component ShiftLeft2Jump is
  generic (n:natural:=32);
  port(X:in std_logic_vector(n-7 downto 0);
       A:in std_logic_vector(3 downto 0);
       Y:out std_logic_vector(n-1 downto 0));
  end component;
  component ShiftLeft2 is
  generic (n:natural:=32);
  port(X:in std_logic_vector(n-1 downto 0);
       Y:out std_logic_vector(n-1 downto 0));
  end component;
  component SignExtended is
  generic (n:natural:=16);
  port(X:in std_logic_vector(n-1 downto 0);
       Y:out std_logic_vector(n*2-1 downto 0));
  end component;
  component MCPC is
	generic (n:natural:=32);
	port(CLK:in std_logic;
	     Enable:in std_logic;
		   AddressIn:in std_logic_vector(n-1 downto 0);
		   AddressOut:out std_logic_vector(n-1 downto 0));
  end component;
  component OR2 is
  port (A,B: in std_logic;C:out std_logic);
  end component;
  component MCInstrReg is
  port (CLK:in STD_LOGIC; 
       Enable:in STD_LOGIC;
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
  end component;
  component MCAReg is
  port (CLK:in STD_LOGIC; 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
  end component;
  component MCBReg is
  port (CLK:in STD_LOGIC; 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
  end component;
  component MCALUOutReg is
  port (CLK:in STD_LOGIC; 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
  end component; 
  component MCMemReg is
  port (CLK:in STD_LOGIC; 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
  end component;



  -- Various signals
  signal C,E,F,G,H,I,J,L,M,N,P,Q,R,S,T,U,V:STD_LOGIC_VECTOR(31 downto 0);
  signal K:STD_LOGIC_VECTOR(4 downto 0);
  signal W,Zero,D:STD_LOGIC;

  -- Full 32-bit instruction
  signal Instruction:STD_LOGIC_VECTOR(31 downto 0);

  -- Out of ALU control
  signal Operation:STD_LOGIC_VECTOR(3 downto 0);

  -- Control out
  signal PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,RegDst,RegWrite,ALUSrcA:STD_LOGIC;
  signal ALUop,ALUSrcB,PCSource:STD_LOGIC_VECTOR(1 downto 0);
  signal four:STD_LOGIC_VECTOR(31 downto 0):="00000000000000000000000000000100";
  
begin     
  MCPC_0:MCPC port map(CLK,D,C,E);
  Mux32_1:Mux32 port map(E,F,IorD,G);
  MCMem_0:MCMemory port map(H,G,MemRead,MemWrite,CLK,I);
  IReg:MCInstrReg port map(CLK,IRWrite,I,Instruction);
  MReg:MCMemReg port map(CLK,I,J);
  MCControl_0:MCControl port map(CLK,Instruction(31 downto 26),PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOp,PCSource);
  ALUControl_0:ALUControl port map(ALUop,Instruction(5 downto 0),Operation);
  Mux5_0:Mux5 port map(Instruction(20 downto 16),Instruction(15 downto 11),RegDst,K);
  Mux32_0:Mux32 port map(F,J,MemtoReg,L);
  MCReg:MCRegisters port map(CLK,RegWrite,Instruction(25 downto 21),Instruction(20 downto 16),K,L,M,N);
  AReg:MCAReg port map(CLK,M,P);
  BReg:MCAReg port map(CLK,N,H);
  SignExt:SignExtended port map(Instruction(15 downto 0),Q);
  SL2:ShiftLeft2 port map(Q,R);
  Mux32_2:Mux32 port map(E,P,ALUSrcA,S);
  Mux32x4:MCMux32x4 port map(H,four,Q,R,ALUSrcB,T);
  ALU_0:ALU port map(S,T,Operation,U,Zero,open,open); --Where are set and overflow?
  ALUReg:MCALUOutReg port map(CLK,U,F);
  
  SLLJ:ShiftLeft2Jump port map(Instruction(25 downto 0),E(31 downto 28),V); --What is this A input? The PC+4[31-28]
  Mux32x3:MCMux32x3 port map(U,F,V,PCSource,C);
  AND_0:AND2 port map(PCWriteCond,Zero,W);
  OR_0:OR2 port map(PCWrite,W,D);
  
end struc;

