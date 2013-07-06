library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity registers is
 port (CLK,RegWrite:in STD_LOGIC;
       RR1,RR2,WR:in STD_LOGIC_VECTOR (4 downto 0); 
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD1,RD2:out STD_LOGIC_VECTOR (31 downto 0));
end registers;

architecture Behavioral of registers is
type reg is array(0 to 31) of std_logic_vector(31 downto 0);
signal regFile:reg;

constant zero:integer:=0;
constant t0:integer:=8;
constant s4:integer:=20;
constant s5:integer:=21;

begin
P1:process(CLK,regWrite,WD,RR1,RR2,WR)
variable R1:integer;
variable R2:integer;
variable WI:integer;
variable first:boolean:=true;
begin
if (first) then
      --Set values for predefnined reg values, $zero, $to, etc
  regFile(zero) <= (others=>'0');
  regFile(t0) <= (5=>'1',3=>'1',others=>'0');
  regFile(s4) <= (3=>'1',2=>'1',1=>'1',others=>'0');
  regFile(s5) <= (2=>'1',0=>'1',others=>'0');
  first := false;
end if;


R1:=conv_integer(unsigned(RR1));
R2:=conv_integer(unsigned(RR2));
WI:=conv_integer(unsigned(WR));

if CLK='1' and CLK'event then
if regWrite='1' then
  if ( not(WI=zero) ) then  --Cannot write to $zero
    regFile(WI)<=WD;
  end if;
end if;
end if;

if CLK='0' and CLK'event then
RD1<=regFile(R1);
RD2<=regFile(R2);
end if;

end process P1;

end Behavioral;


