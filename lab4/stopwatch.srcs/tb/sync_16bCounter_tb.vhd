--------------------------------
-- 16b synchronus counter tb
--------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- tb entity
entity sync_16bCounter_tb is
end sync_16bCounter_tb;

architecture testbench of sync_16bCounter_tb is

	-- Signals
	signal clk				: STD_LOGIC := '0';
	constant clk_period		: time		:= 10 ns;

	signal	reset, enable	: STD_LOGIC	:= '0';
	signal	value			: STD_LOGIC_VECTOR( 15 downto 0 ) := ( others => '0');

	-- uut	
	component sync_16bCounter 
	port (
			-- inputs
			reset	: in STD_LOGIC;
			enable	: in STD_LOGIC;
			clk		: in STD_LOGIC;

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
	uut : sync_16bCounter
		port map( clk => clk, reset => reset, enable => enable, value => value );

	-- Stimulus
	stimulus : process
	begin
		
		wait for clk_period;
		enable <= '1';
		wait for clk_period;
		wait for clk_period;
		reset <= '1';
		wait for clk_period;
		reset <= '0';
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
		enable <= '0';
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
