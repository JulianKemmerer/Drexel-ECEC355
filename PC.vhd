-- Kyle Juretus, Dave Werner, Julian Kemmerer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
	generic (n:natural:=32);
	port(CLK:in std_logic;
		  AddressIn:in std_logic_vector(n-1 downto 0);
		  AddressOut:out std_logic_vector(n-1 downto 0));
end PC;

architecture Behavioral of PC is
signal count:integer:=0;
begin

P1:process(CLK,AddressIn)
begin
if CLK='1' and CLK'event then
if count=0 then
  AddressOut<= (others=>'0');
else 
  AddressOut<=AddressIn;
end if;
   count<=count+1;
end if;

end process P1;

end Behavioral;



