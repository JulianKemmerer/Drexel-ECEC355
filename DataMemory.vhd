library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity DataMemory is
	port(WriteData:in std_logic_vector(31 downto 0);
		   Address:in std_logic_vector(31 downto 0);
		   MemRead,MemWrite,CLK:in std_logic;
		   ReadData:out std_logic_vector(31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
type mem is array(0 to 255) of std_logic_vector(7 downto 0); 
signal memArray:mem;

begin
P1:process(CLK,MemRead,MemWrite,WriteData)
variable r:integer;
variable first:boolean:=true;
begin
if (first) then
  memArray(0) <= "00000000";  
    memArray(1) <= "00000000";  
      memArray(2) <= "00000000";  
        memArray(3) <= "00000100";

          memArray(4) <= "00000000";  
            memArray(5) <= "00000000";  
              memArray(6) <= "00000000";  
                memArray(7) <= "00000100";  
                  first:=false;
end if;
if CLK='1' and CLK'event then
r:=conv_integer(unsigned(Address));
  if MemWrite='1' and MemRead='0' then 
    memArray(r)<=WriteData(31 downto 24);
    memArray(r+1)<=WriteData(23 downto 16);
    memArray(r+2)<=WriteData(15 downto 8);
    memArray(r+3)<=WriteData(7 downto 0);
  end if;
end if;
if CLK='0' and CLK'event then
r:=conv_integer(unsigned(Address));
  if MemRead='1' and MemWrite='0' then
    ReadData<=memArray(r) & memArray(r+1) & memArray(r+2) & memArray(r+3);
  end if;
end if;

end process P1;


end Behavioral;



