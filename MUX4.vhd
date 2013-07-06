library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX4 is
    Port ( DATA_IN:in STD_LOGIC_VECTOR(3 downto 0);SEL:in STD_LOGIC_VECTOR(1 downto 0);ENABLE:in STD_LOGIC;DATA_OUT : out  STD_LOGIC);
end MUX4;

architecture Behavioral of MUX4 is
begin
  process(DATA_IN,SEL,ENABLE)
    begin
      if ENABLE='1' then
        if SEL="00" then
          DATA_OUT<=DATA_IN(0);
        elsif SEL="01" then
          DATA_OUT<=DATA_IN(1);
        elsif SEL="10" then
          DATA_OUT<=DATA_IN(2);
        elsif SEL="11" then
          DATA_OUT<=DATA_IN(3);
        else
          DATA_OUT<=DATA_IN(0); --Default to 0
        end if;
      else
        DATA_OUT<='Z';
    end if;

  end process;
end Behavioral;




