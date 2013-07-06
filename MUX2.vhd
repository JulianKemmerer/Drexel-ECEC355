library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2 is
    Port ( DATA_IN:in STD_LOGIC_VECTOR(1 downto 0);SEL:in STD_LOGIC;ENABLE:in STD_LOGIC;DATA_OUT : out  STD_LOGIC);
end MUX2;

architecture Behavioral of MUX2 is
begin
  process(DATA_IN,SEL,ENABLE)
    begin
      if ENABLE='1' then
        if SEL='0' then
          DATA_OUT<=DATA_IN(0);
        elsif SEL='1' then
          DATA_OUT<=DATA_IN(1);
        else
          DATA_OUT<=DATA_IN(0); --default to 0
        end if;
      else
        DATA_OUT<='Z';
    end if;

  end process;
end Behavioral;

