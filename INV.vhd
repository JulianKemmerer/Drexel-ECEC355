library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inv is
  port(A:in STD_LOGIC;B:out STD_LOGIC);
end inv;

architecture df of inv is
  begin
  B <= not A;
end df;


