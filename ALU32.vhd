library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--ALU entity description as specified by Prabhu
--May need ot add 'zero' and 'overflow' signals
entity ALU is
generic(n:natural:=32);
port(a,b:in std_logic_vector(n-1 downto 0);
	  Oper:in std_logic_vector(3 downto 0);
	  Result:buffer std_logic_vector(n-1 downto 0);
	  Zero,Set,Overflow:buffer std_logic);
end ALU;

architecture struc of ALU is
  
--Dave's ALU1
component ALU1 is
port(
    A, B, AInvert, BInvert, CarryIn, Less:in STD_LOGIC;
    Operation:in STD_LOGIC_VECTOR(1 downto 0);
    Result, Set, CarryOut :out STD_LOGIC
    );
end component;

component NOR32 is
port(
    X:in std_logic_vector(n-1 downto 0);
    Y:out std_logic
    );
end component;
component XOR2 is
port(
    A,B: in std_logic;
    C:out std_logic
    );
end component;

--Signal declarations
--Carry sigs
--CARRY[0] represents the carry coming into alu1[0]
--this will go up to alu1[31] and CARRY[31]
--A final signal is used for the carry out for ALU31 (disconnected I believe, but I will still have it here for consistency)
--A total of 33 carry signals, 0 to n
signal CARRY:STD_LOGIC_VECTOR(0 to n);
--A and b are applied directlly to each alu1 unit, no additonal signals needed
--3 signals need to be taken out of the operation vector
--The arrangement of the bits within Oper coming in may need to be changed (below)
signal ainvert, binvert: std_logic; -- 1 bit ainvert and binvert signals
signal operation: STD_LOGIC_VECTOR(1 downto 0); --two bit selection for the operation mux with each ALU1
--bnegate in the schematic is the same as b invert but is routed differently
--Result also is sent directly out, no additonal signals needed
--Less and set are not sent directly into the alu1's so create a vector for them
signal LESS:STD_LOGIC_VECTOR(0 to n-1);
signal SETInternal:STD_LOGIC;

begin  
  --First seperate the bits from the 4 it op code sent in
  --This may need to be changed because Julian doesn't pay attention in class...enough---------------------------HEY IMPORTANT LINE HERE<
  --Lol ^^
  ainvert <= Oper(3);
  binvert <= Oper(2);
  operation <= Oper(1 downto 0);
  
  --Manually assign signals for exception cases
  --ALU1[0]
  --for alu10 binvert is also routed to carry in
  carry(0)<=binvert;
  
  --ALU1[31]
  --LESS is 0 unless it is into alu1[0] (handled above)
  --Loop through the remainder of LESS to assign zeros
  LESS_GEN: for j in 1 to n-1 generate
    LESS(j) <= '0';
  end generate LESS_GEN;
  --OVERFLOW from ALU1[31] is signaled by ...how is overflow done? ---------------------------HEY IMPORTANT LINE HERE<
  X1:XOR2 port map(carry(n),carry(n-1),Overflow);
  --REPLACED  --Also less is input from the set of ALU1[31]
  --REPLACED  LESS(0) <= SET(n-1);
  X2:XOR2 port map(SETInternal,Overflow,Less(0));
  Set <= Less(0);  
      
  NOR1:NOR32 port map(Result,Zero);    
  --Generate the main structure of the ALU  
  MAIN_GEN: for i in 0 to n-2 generate     
    --carry[i] is in as noted above                     --carry[i+1] is the out of alu1[i] and the in of alu1[i+1]
    ALU1GEN: ALU1 port map(a(i),b(i),ainvert,binvert,carry(i),LESS(i),operation,Result(i),open,carry(i+1)); 
  end generate MAIN_GEN;
  ALU1Last: ALU1 port map(a(n-1),b(n-1),ainvert,binvert,carry(n-1),LESS(n-1),operation,Result(n-1),SETInternal,carry(n)); 
end struc;













