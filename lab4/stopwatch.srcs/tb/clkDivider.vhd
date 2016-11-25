-------------------
-- Stopwatch FSM tb
------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--tb entity
entity clk_divider_tb is
end clk_divider_tb;

architecture testbench of clk_divider_tb is

	--Signals 
	signal clk_in		: STD_LOGIC	:= '0';
	constant clk_period : time := 10 ns;

	signal clk_out 		: STD_LOGIC := '0';

	-- uut 
	component clk_divider
	port (
			clk_100MHz 	: in STD_LOGIC;
			clk_100Hz	: out STD_LOGIC
		);
	end component;

begin


	--Clk process
	clk_process : process
	begin
		clk_in <= NOT( clk_in );
		wait for clk_period/2;
	end process;

	-- uut
	uut : clk_divider
		port map( clk_100MHz => clk_in, clk_100Hz => clk_out );

	--Stimulus
	stimulus : process
	begin

		
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait;
	end process;
end;
