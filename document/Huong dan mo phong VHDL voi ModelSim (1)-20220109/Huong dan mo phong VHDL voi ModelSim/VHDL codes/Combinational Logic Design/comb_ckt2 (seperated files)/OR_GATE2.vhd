------------------------------------------------------------
-- Combinational Logic Design	
-- (ESD book figure 2.4)	
-- by Weijun Zhang, 04/2001
--
-- A simple example of VHDL Structure Modeling
-- we might define two components in two separate files,
-- in main file, we use port map statement to instantiate 
-- the mapping relationship between each components 
-- and the entire circuit.	
------------------------------------------------------------

library ieee;				-- component #1
use ieee.std_logic_1164.all;

entity OR_GATE2 is
port(  	X:	in std_logic;
	Y:	in std_logic;
	F2:	out std_logic
);
end OR_GATE2;

architecture behv of OR_GATE2 is
begin
process(X,Y)
begin
	F2 <= X or Y;			-- behavior des.
end process;
end behv;
