-------------------
-- Stopwatch FSM tb
------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--tb entity
entity stopwatch_FSM_tb is
end stopwatch_FSM_tb;

architecture testbench of stopwatch_FSM_tb is

	-- Signals
	signal clk			: STD_LOGIC := '0';
	constant clk_period	: time		:= 10 ns;

	signal button		: STD_LOGIC := '0';
	signal value		: STD_LOGIC_VECTOR( 15 downto 0 ) := ( others => '0' );

	-- uut
	component stopwatch_FSM
	port (
			-- inputs
			clk		: in STD_LOGIC;
			button	: in STD_LOGIC;

			--outputs
			value	: out STD_LOGIC_VECTOR( 15 downto 0 )
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
	uut : stopwatch_FSM
		port map( clk => clk, button => button, value => value );

	--Stimulus
	stimulus : process
	begin

		
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		button <= '1';
		wait for clk_period;
		button <= '0';
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
		button <= '1';
		wait for clk_period;
		button <= '0';
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		button <= '1';
		wait for clk_period;
		button <= '0';
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait;
	end process;
end;
