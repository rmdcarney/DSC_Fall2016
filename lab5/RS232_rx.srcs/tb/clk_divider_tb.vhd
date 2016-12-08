---------------------------
-- Clk divider with PLL tb
---------------------------

library IEEE;
library UNISIM;

use IEEE.STD_LOGIC_1164.all;
use UNISIM.vcomponents.all;

-- tb entity
entity clkDivider_tb is
end clkDivider_tb;

architecture testbench of clkDivider_tb is

	-- Signals
	signal clk			: STD_LOGIC := '0';
	constant clk_period : time 		:= 10 ns;

	signal outputClk	: STD_LOGIC := '0';

	-- uut 
	component clk_divider 
	port(
			clk_100MHz		: in STD_LOGIC;
			clk_153_6_kHz	: out STD_LOGIC
		);
	end component;

begin

	clkModule : clk_divider
		port map( clk_100MHz => clk, clk_153_6_kHz => outputClk );

	-- Clk process
	clk_process : process
	begin
		clk <= NOT( clk );
		wait for clk_period/2;
	end process;

	stimulus : process
	begin
		wait;
	end process;
end;

