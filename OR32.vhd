library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;

entity OR32 is
port( x:in std_logic_vector(31 downto 0);
      y: out std_logic);
end  OR32;

architecture struc of OR32 is
component ORn
  generic (n:natural:=32);
   port(X:in std_logic_vector(n-1 downto 0);Y:out std_logic);
 end component;

 begin
   
O32:ORn port map(x,y);
   
end struc;

