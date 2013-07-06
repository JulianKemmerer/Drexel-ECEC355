library ieee;
use ieee.std_logic_1164.all;
entity MCControl is
port(clk:in std_logic; 
Opcode:in std_logic_vector(5 downto 0); 
PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemToReg,IRWrite,RegDst,RegWrite,ALUSrcA:out std_logic;
ALUSrcB,ALUOp,PCSource:out std_logic_vector(1 downto 0));
end MCControl;
architecture behav of MCControl is
type state is (S0,S01,S1,S2,S3,S4,S5,S6,S7,S8,S9);
signal n_s:state;
begin
process(clk,Opcode)
variable init:integer:=0;
begin

if clk='1' and clk'event then



case n_s is
when S0=>
PCWriteCond<='U';
PCWrite<='1';
IorD<='0';
MemRead<='1';
MemWrite<='0';
MemToReg<='U';
IRWrite<='1';
RegDst<='U';
RegWrite<='0';
ALUSrcA<='0';
ALUSrcB<="01";
ALUOp<="00";
PCSource<="00";


n_s<=S1;

when S01=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='0';
MemRead<='1';
MemWrite<='0';
MemToReg<='U';
IRWrite<='0';
RegDst<='U';
RegWrite<='0';
ALUSrcA<='0';
ALUSrcB<="01";
ALUOp<="00";
PCSource<="00";

n_s<=S1;

when S1=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='0';
MemRead<='1';
MemWrite<='0';
MemToReg<='U';
IRWrite<='0';
RegDst<='U';
RegWrite<='0';
ALUSrcA<='0';
ALUSrcB<="11";
ALUOp<="00";
PCSource<="00";

if Opcode="000000" then
  n_s<=S6;
elsif Opcode="100011" then
  n_s<=S2;
elsif Opcode="101011" then
  n_s<=S2;
elsif Opcode="000100" then
  n_s<=S8;
elsif Opcode="000010" then
  n_s<=S9;
end if;

when S2=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='0';
MemRead<='1';
MemWrite<='0';
MemToReg<='U';
IRWrite<='0';
RegDst<='U';
RegWrite<='0';
ALUSrcA<='1';
ALUSrcB<="10";
ALUOp<="00";
PCSource<="00";

if Opcode="100011" then
  n_s<=S3;
elsif Opcode="101011" then
  n_s<=S5;
end if;

when S3=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='1';
MemRead<='1';
MemWrite<='0';
MemToReg<='U';
IRWrite<='0';
RegDst<='U';
RegWrite<='0';
ALUSrcA<='0';
ALUSrcB<="10";
ALUOp<="00";
PCSource<="00";

n_s<=S4;

when S4=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='1';
MemRead<='1';
MemWrite<='0';
MemToReg<='1';
IRWrite<='0';
RegDst<='0';
RegWrite<='1';
ALUSrcA<='0';
ALUSrcB<="10";
ALUOp<="00";
PCSource<="00";

init:=0;
n_s<=S0;

when S5=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='1';
MemRead<='0';
MemWrite<='1';
MemToReg<='1';
IRWrite<='0';
RegDst<='0';
RegWrite<='0';
ALUSrcA<='0';
ALUSrcB<="10";
ALUOp<="00";
PCSource<="00";

init:=0;
n_s<=S0;

when S6=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='1';
MemRead<='0';
MemWrite<='1';
MemToReg<='1';
IRWrite<='0';
RegDst<='0';
RegWrite<='0';
ALUSrcA<='1';
ALUSrcB<="00";
ALUOp<="10";
PCSource<="00";

n_s<=S7;


when S7=>
PCWriteCond<='U';
PCWrite<='0';
IorD<='1';
MemRead<='0';
MemWrite<='0';
MemToReg<='0'; -- YOU AHD THIS AS 1 AHHHHHHHHHHHHHHHH
IRWrite<='0';
RegDst<='1';
RegWrite<='1';
ALUSrcA<='0';
ALUSrcB<="00";
ALUOp<="10";
PCSource<="00";

init:=0;
n_s<=S0;

when S8=>
PCWriteCond<='1';
PCWrite<='0';
IorD<='1';
MemRead<='0';
MemWrite<='0';
MemToReg<='1';
IRWrite<='0';
RegDst<='1';
RegWrite<='1';
ALUSrcA<='1';
ALUSrcB<="00";
ALUOp<="01";
PCSource<="01";

init:=0;
n_s<=S0;

when S9=>
PCWriteCond<='U';
PCWrite<='1';
IorD<='1';
MemRead<='0';
MemWrite<='0';
MemToReg<='1';
IRWrite<='0';
RegDst<='1';
RegWrite<='0';
ALUSrcA<='0';
ALUSrcB<="00";
ALUOp<="01";
PCSource<="10";

init:=0;
n_s<=S0; 


end case;

end if;

end process;
end behav;
