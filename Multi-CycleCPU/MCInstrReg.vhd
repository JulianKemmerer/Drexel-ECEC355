library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity MCInstrReg is
 port (CLK:in STD_LOGIC; 
       Enable:in STD_LOGIC;
       WD:in STD_LOGIC_VECTOR (31 downto 0);
		   RD:out STD_LOGIC_VECTOR (31 downto 0));
end MCInstrReg;

architecture Behavioral of MCInstrReg is


begin

P1:process(CLK,Enable,WD)
variable regFile:std_logic_vector(31 downto 0);
begin

  if CLK='0' and CLK'event and Enable='1' then  
  regFile:=WD;
  --RD<=regFile;
  end if;

  if CLK='0' and CLK'event then 
    RD<=regFile;
  end if;
  

end process P1;

end Behavioral;
