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

library ieee;				-- component #2
use ieee.std_logic_1164.all;

entity AND_GATE2 is
port(  	A:	in std_logic;
	B:	in std_logic;
	F1:	out std_logic
);
end AND_GATE2;

architecture behv of AND_GATE2 is
begin
process(A,B)
begin
	F1 <= A and B;			-- behavior des.
end process;
end behv;
