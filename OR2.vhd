library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR2 is
  port (A,B: in std_logic;C:out std_logic);
end OR2;

architecture df of OR2 is
begin
  C<=A or B;
end df;