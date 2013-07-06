library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity MCALUOutReg is
 port (CLK:in STD_LOGIC; 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
end MCALUOutReg;

architecture Behavioral of MCALUOutReg is
signal regFile:std_logic_vector(31 downto 0);

begin
P1:process(CLK,WD)
variable R1:integer;
variable R2:integer;
variable WI:integer;
begin

if CLK='1' and CLK'event then  
  regFile<=WD;
end if;

if CLK='0' and CLK'event then
  RD<=regFile;
end if;

end process P1;

end Behavioral;
