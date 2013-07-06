library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND2 is
  port (X,Y: in std_logic;Z:out std_logic);
end AND2;

architecture df of AND2 is
begin
  Z<=X and Y;
end df;

