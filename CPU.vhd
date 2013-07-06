library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
  port(clk:in std_logic; Overflow:out std_logic);
end CPU;

architecture struc of CPU is


  component ALU32 is
    generic(n:natural:=32);
    port(a,b:in std_logic_vector(n-1 downto 0);
	  Oper:in std_logic_vector(3 downto 0);
	  Result:buffer std_logic_vector(n-1 downto 0);
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
  component Control is
  port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
  end component;
  component DataMemory is
	port(WriteData:in std_logic_vector(31 downto 0);
		   Address:in std_logic_vector(31 downto 0);
		   MemRead,MemWrite,CLK:in std_logic;
		   ReadData:out std_logic_vector(31 downto 0));
  end component;
  component InstructionMemory is
	port(Address:in std_logic_vector(31 downto 0);
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
  component registers is
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
  component PC is
	generic (n:natural:=32);
	port(CLK:in std_logic;
		  AddressIn:in std_logic_vector(n-1 downto 0);
		  AddressOut:out std_logic_vector(n-1 downto 0));
  end component;



  -- Various signals
  signal A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R:STD_LOGIC_VECTOR(31 downto 0);

  -- Full 32-bit instruction
  signal Instruction:STD_LOGIC_VECTOR(31 downto 0);

  -- Out of ALU control
  signal Operation:STD_LOGIC_VECTOR(3 downto 0);

  -- Control out
  signal RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump,Zero:STD_LOGIC;
  signal ALUOp:STD_LOGIC_VECTOR(1 downto 0);
  signal four:STD_LOGIC_VECTOR(31 downto 0)=:"00000000000000000000000100";
  
begin     
  --PC: --What is the PC...?
  IM:InstructionMemory port map(A,Instruction);
  Control_0:Control port map(Instruction(31 downto 26),RegDst,Branch,MemRead,MemToReg,MemWrite,ALUSrc,RegWrite,Jump,ALUop);
  Mux5_0:Mux5 port map(Instruction(20 downto 16),Instruction(15 downto 11),B);
  Reg:registers port map(CLK,RegWrite,Instruction(25 downto 21),Instruction(20 downto 16),B,J,C,D);
  SignExt:SignExtended port map(Instruction(15 downto 0),E);
  Mux32_0:Mux32 port map(D,E,F);
  ALU:ALU32 port map(C,D,Operation,G,Zero,open,open); --Where are set and overflow?
  DM:DataMemory port map(D,G,MemRead,MemWrite,CLK,H);
  Mux32_1:Mux32 port map(H,G,J);
  
  ADD4:ALU port map(A,four,L);
  SLLJ:ShiftLeft2Jump port map(Instruction(25 downto 0),L(31 downto 28),Q); --What is this A input? The PC+4[31-28]
  SLLALU:ShiftLeft2 port map(E,K);
  ADD:ALU port map(L,K,M);
  AND_0:AND2 port map(Branch,Zero,R);
  MuxPC_0:MUX32 port map(L,M,R,N);
  MuxPC_1:MUX32 port map(Q,N,Jump,P);
  
end struc;