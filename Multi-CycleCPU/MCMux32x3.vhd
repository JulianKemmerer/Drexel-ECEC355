library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MCMUX32x3 is
    Port ( D1:in STD_LOGIC_VECTOR(31 downto 0);
           D2:in STD_LOGIC_VECTOR(31 downto 0);
           D3:in STD_LOGIC_VECTOR(31 downto 0);
           SEL:in STD_LOGIC_VECTOR(1 downto 0);
           DOUT : out  STD_LOGIC_VECTOR(31 downto 0));
end MCMUX32x3;

architecture Behavioral of MCMUX32x3 is
begin
  process(SEL,D1,D2,D3)
    begin
        if SEL="00" then
          DOUT<=D1;
        elsif SEL="01" then
          DOUT<=D2;
        elsif SEL="10" then
          DOUT<=D3;
        end if;

  end process;
end Behavioral;
