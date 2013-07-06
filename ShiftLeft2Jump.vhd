library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeft2Jump is
  generic (n:natural:=32);
  port(X:in std_logic_vector(n-7 downto 0);
       A:in std_logic_vector(3 downto 0);
       Y:out std_logic_vector(n-1 downto 0));
end ShiftLeft2Jump;

architecture behav of ShiftLeft2jump is
  begin
    P1:process(X,A)
      begin
      Y<= A & X & "00";
    end process P1;
end behav;
