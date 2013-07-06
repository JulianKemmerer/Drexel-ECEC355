library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;

entity NOR32 is
port( x:in std_logic_vector(31 downto 0);
      y: out std_logic);
end  NOR32;

architecture struc of NOR32 is
component NORn
  generic (n:natural:=32);
   port(X:in std_logic_vector(n-1 downto 0);Y:out std_logic);
 end component;

 begin
   
N32:NORn port map(x,y);
   
end struc;