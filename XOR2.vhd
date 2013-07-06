library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR2 is
  port (A,B: in std_logic;C:out std_logic);
end XOR2;

architecture df of XOR2 is
begin
  C<=A xor B;
end df;
