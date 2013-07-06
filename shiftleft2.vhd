-- Kyle Juretus, Dave Werner, Julian Kemmerer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeft2 is
  generic (n:natural:=32);
  port(X:in std_logic_vector(n-1 downto 0);
       Y:out std_logic_vector(n-1 downto 0));
end ShiftLeft2;

architecture behav of ShiftLeft2 is
  begin
    P1:process(X)
      begin
      Y<=X(n-3 downto 0) & "00";
    end process P1;
	 
end behav;



