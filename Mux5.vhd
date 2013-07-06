library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX5 is
port(x,y:in std_logic_vector (4 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(4 downto 0));
end MUX5;

architecture behav of MUX5 is
  begin
    P1:process(x,y,sel)
    begin
      --Default to x
      if sel = '1' then
        z <= y;
      else
        z <= x;
      end if; 
    end process P1;
end behav;
