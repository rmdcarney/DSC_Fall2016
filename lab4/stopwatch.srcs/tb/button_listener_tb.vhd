----------------
-- Button Listener TB
-------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- tb entity
entity button_listener_tb is
end button_listener_tb;

architecture testbench of button_listener_tb is

	-- Signals
	signal clk			: STD_LOGIC := '0';
	constant clk_period	: time		:= 10 ns;

	signal button, output: STD_LOGIC := '0';

	-- uut
	component button_listener
	port (
			-- inputs 
			clk		: in STD_LOGIC;
			button	: in STD_LOGIC;

			--outputs
			output	: out STD_LOGIC
		 );
	end component;

begin 

	--Clk process
	clk_process : process
	begin
		clk <= NOT( clk );
		wait for clk_period/2;
	end process;

	-- uut
	uut : button_listener
		port map( clk => clk, button => button, output => output );

	-- Stimulus
	stimulus : process
	begin
		
		wait for clk_period;
		wait for clk_period/2;
		button <= '1';
		wait for clk_period/4;
		button <= '0';
		wait for clk_period/4;
		wait for clk_period/4;
		wait for clk_period/4;
		wait for clk_period;
		wait for clk_period;
		button <= '1';
		wait for clk_period;
		wait for clk_period/4;
		button <= '0';
		wait for clk_period/4;
		wait for clk_period/4;
		wait for clk_period/4;
		wait for clk_period;
		wait for clk_period/4;
		button <= '1';
		wait for clk_period;
		button <= '0';
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait;
	end process;
end;
		

