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

library ieee;				-- top level circuit
use ieee.std_logic_1164.all;
use work.all;

entity comb_ckt2 is
port(	input1: in std_logic;
	input2: in std_logic;
	input3: in std_logic;
	output: out std_logic
);
end comb_ckt2;

architecture struct of comb_ckt2 is

    component AND_GATE2 is		-- as entity of AND_GATE2
    port(   A:	in std_logic;
    	    B:	in std_logic;
            F1:	out std_logic
    );
    end component;

    component OR_GATE2 is		-- as entity of OR_GATE2
    port(   X:	in std_logic;
    	    Y:	in std_logic;
    	    F2: out std_logic
    );
    end component;

    signal wire: std_logic;		-- signal just like wire

begin

    -- use sign "=>" to clarify the pin mapping

    Gate1: AND_GATE2 port map (A=>input1, B=>input2, F1=>wire);
    Gate2: OR_GATE2 port map (X=>wire, Y=>input3, F2=>output);

end struct;

----------------------------------------------------------------
