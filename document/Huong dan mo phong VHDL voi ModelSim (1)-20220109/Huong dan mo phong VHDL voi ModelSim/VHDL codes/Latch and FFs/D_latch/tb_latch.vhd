-------------------------------------------------------------------
-- Test Bench for simple latch(ESD 2.3.1)
-- by Weijun Zhang, 04/2001
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity latch_TB is			-- entity declaration
end latch_TB;

-------------------------------------------------------------------

architecture TB of latch_TB is

    signal T_data_in: 	std_logic;
    signal T_enable:	std_logic;
    signal T_data_out:	std_logic;
	
    component D_latch
    port(	data_in:	in std_logic;
		enable:		in std_logic;
		data_out:	out std_logic
    );
    end component;
		
begin

    U_latch: D_latch port map (T_data_in, T_enable, T_data_out);
	
    process

	variable err_cnt: integer := 0;

    begin
		
	T_data_in <= '1';	  
	T_enable <= '0';
	wait for 20 ns;		   
	
	-- case 1	
	T_enable <= '1';
	wait for 5 ns;
	assert(T_data_out='1') report "Error1!" severity error;
	if (T_data_out/='1') then
	    err_cnt := err_cnt + 1;
	end if;

	-- case 2
	T_data_in <= '0'; 
	wait for 20 ns;		
	assert(T_data_out='0') report "Error2!" severity error;
	if (T_data_out/='0') then
	    err_cnt := err_cnt + 1;
	end if;
		
	-- case 3
	T_data_in <= '1'; 
	wait for 20 ns;		
	assert(T_data_out='1') report "Error3!" severity error;
	if (T_data_out/='1') then
	    err_cnt := err_cnt + 1;
	end if;
		
	-- case 4
	T_enable <= '0';
	T_data_in <= '0'; 
	wait for 20 ns;						  
	assert(T_data_out='1') report "Error4!" severity error;
	if (T_data_out/='1') then
	    err_cnt := err_cnt + 1;
	end if;

	-- case 5
	T_enable <= '1';
	wait for 5 ns;
	assert(T_data_out='0') report "Error5!" severity error;
	if (T_data_out/='0') then
	    err_cnt := err_cnt + 1;
	end if;
		
	-- summary of all the tests
	if (err_cnt=0) then 			
	    assert false 
	    report "Testbench of Adder completed successfully!" 
	    severity note; 
	else 
	    assert true 
	    report "Something wrong, try again" 
	    severity error; 
	end if; 

	wait;

    end process;

end TB;

--------------------------------------------------------------------
configuration CFG_TB of latch_TB is
	for TB
	end for;
end CFG_TB;
---------------------------------------------------------------------
