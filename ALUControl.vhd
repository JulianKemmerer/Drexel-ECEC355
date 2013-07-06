library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity from handout
entity ALUControl is
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end ALUControl;


architecture behav of ALUControl is
begin
process(ALUOp,Funct)
  variable funct3_0:std_logic_vector(3 downto 0); --last 4 bits of Funct
begin
  --Get last 4 bits of funct
  funct3_0 := Funct(3 downto 0);
  
  if ALUOp="00" then
    --Funct is don't care
    Operation <= "0010";
  elsif ALUOp="01" then
    --Funct is don't care
    Operation <= "0110";
    
  elsif ((ALUOp="10") and (funct3_0="0000")) then
    Operation <= "0010";
  elsif ((ALUOp(1)='1') and (funct3_0="0010")) then --ALUOp0 x
    Operation <= "0110";
  elsif ((ALUOp="10") and (funct3_0="0100")) then
    Operation <= "0000";
  elsif ((ALUOp="10") and (funct3_0="0101")) then
    Operation <= "0001";
  elsif ((ALUOp(1)='1') and (funct3_0="1010")) then --ALUOp0 x
    Operation <= "0111";
  else
    Operation <= "UUUU";
  end if;
  
end process;
end behav;