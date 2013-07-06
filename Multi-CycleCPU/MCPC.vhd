library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MCPC is
	generic (n:natural:=32);
	port(CLK:in std_logic;
	    Enable:in std_logic;
		  AddressIn:in std_logic_vector(n-1 downto 0);
		  AddressOut:out std_logic_vector(n-1 downto 0));
end MCPC;

architecture Behavioral of MCPC is
begin

P1:process(CLK,Enable,AddressIn)
variable count:integer:=0;
begin
if CLK='1' and CLK'event then
  if count=0 then
    AddressOut<= (others=>'0');
    count:=1;
  end if;
  if Enable='1' then
  AddressOut<=AddressIn;
  end if;
end if;

end process P1;

end Behavioral;
