library ieee;
use ieee.std_logic_1164.all;

entity NORn is
  generic(n:natural:=4);
  port(X:in std_logic_vector(n-1 downto 0);Y:out std_logic);
end NORn;
  
architecture behav of NORn is
begin
  process(X)
    variable temp:std_logic;
  begin
    temp:=X(0);
    for i in 1 to n-1 loop --or all inputs
     temp:=temp or X(i);
    end loop;
    temp:= not temp; --invert result
    Y<=temp;
  end process;
end behav;
     