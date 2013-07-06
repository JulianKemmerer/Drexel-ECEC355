library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux32 is
    Port ( 
    X,Y:in STD_LOGIC_VECTOR(31 downto 0);
    SEL:in STD_LOGIC;
    Z: out  STD_LOGIC_VECTOR(31 downto 0));
end Mux32;

architecture Behavioral of Mux32 is
begin
  process(X,Y,SEL)
    begin
      if SEL='0' then
        Z <= X;
      elsif SEL='1' then
        Z <= Y;
      else
        Z <= (others => 'Z');
    end if;
  end process;
end Behavioral;