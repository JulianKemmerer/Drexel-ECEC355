library ieee;
use ieee.std_logic_1164.all;

entity FAPE is
port(A,B,CIN:in STD_LOGIC;S,COUT:out STD_LOGIC);
end FAPE;

architecture struc of FAPE is -- using basic gates
component OR2
  port(A,B:in STD_LOGIC; C:out STD_LOGIC);
end component;
component XOR2
  port(A,B:in STD_LOGIC; C:out STD_LOGIC);
end component;
component AND2
  port(X,Y:in STD_LOGIC; Z:out STD_LOGIC);
end component;
signal S1,S2,S3:STD_LOGIC;     -- signals are connecting wires
begin
  X1:XOR2 port map(A,B,S1);
  X2:XOR2 port map(S1,CIN,S);
  A1:AND2 port map(S1,CIN,S2);
  A2:AND2 port map(A,B,S3);
  O1:OR2 port map(S2,S3,COUT);
end struc;