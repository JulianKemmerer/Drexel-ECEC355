-- Kyle Juretus, Dave Werner, Julian Kemmerer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtended is
  generic (n:natural:=16);
  port(X:in std_logic_vector(n-1 downto 0);
       Y:out std_logic_vector(n*2-1 downto 0));
end SignExtended;

architecture behav of SignExtended is
  begin
    P1:process(X)
      begin
      --Y(n*2-1)<=X(n-1);
      Y(n-2 downto 0)<=X(n-2 downto 0);
      Y(n*2-1 downto n-1)<= (others=> X(n-1));
    end process P1;
end behav;



