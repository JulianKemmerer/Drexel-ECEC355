library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity MCMemory is
	port(WriteData:in std_logic_vector(31 downto 0);
	     Address:in std_logic_vector(31 downto 0);
	     MemRead,MemWrite,CLK:in std_logic;
		   ReadData:out std_logic_vector(31 downto 0));
end MCMemory;

architecture Behavioral of MCMemory is
type mem is array(0 to 256) of std_logic_vector(7 downto 0);
signal memArray:mem;

begin
P1:process(CLK,Address,WriteData,MemRead,MemWrite)
variable r:integer;
variable first:boolean:=true;
begin
  if(first) then
-- lw  $s0,0($t0)  $t0 now at 40
memArray(0)<="10001101";
memArray(1)<="00010000";
memArray(2)<="00000000";
memArray(3)<="00000000";

-- lw  $s1,4($t0) $t0 now at 40
memArray(4)<="10001101";
memArray(5)<="00010001";
memArray(6)<="00000000";
memArray(7)<="00000100";

-- beq $s0,$s1,L
memArray(8)<="00010010";
memArray(9)<="00010001";
memArray(10)<="00000000";
memArray(11)<="00000010";

-- add $s3,$s4,$s5
memArray(12)<="00000010";
memArray(13)<="10010101";
memArray(14)<="10011000";
memArray(15)<="00100000";

-- j exit
memArray(16)<="00001000";
memArray(17)<="00000000";
memArray(18)<="00000000";
memArray(19)<="00000110"; 

-- L:       sub $s3,$s4,$s5
memArray(20)<="00000010";
memArray(21)<="10010101";
memArray(22)<="10011000";
memArray(23)<="00100010";

-- exit:  sw $s3,8($t0)
memArray(24)<="10101101";
memArray(25)<="00010011";
memArray(26)<="00000000";
memArray(27)<="00001000";

--Initialize Memory
memArray(40) <= "00000000";  
memArray(41) <= "00000000";  
memArray(42) <= "00000000";  
memArray(43) <= "00000100";
memArray(44) <= "00000000";  
memArray(45) <= "00000000";  
memArray(46) <= "00000000";  
memArray(47) <= "00000100";  

first:=false;  
end if;

if CLK='1' and CLK'event then
r:=conv_integer(unsigned(Address));
  if MemWrite='1' and MemRead='0' then 
        if ((r<=250)and (r>=0)) then
    memArray(r)<=WriteData(31 downto 24);
    memArray(r+1)<=WriteData(23 downto 16);
    memArray(r+2)<=WriteData(15 downto 8);
    memArray(r+3)<=WriteData(7 downto 0);
  end if;
  end if;
end if;


r:=conv_integer(unsigned(Address));
  if MemRead='1' and MemWrite='0' then
    if ((r<=250)and (r>=0)) then
      ReadData<=memArray(r) & memArray(r+1) & memArray(r+2) & memArray(r+3);
    end if;
  end if;


end process P1;

end Behavioral;

