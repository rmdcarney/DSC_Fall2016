-------------------------
-- Stopwatch : testbench
-------------------------

library IEEE;
library UNISIM;

use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use UNISIM.vcomponents.all;

-- entity declaration
entity stopwatch_tb is
end stopwatch_tb;

architecture testbench of stopwatch_tb is

	--Signals 
	signal clk_100MHz, button		: STD_LOGIC := '0';
	constant clk_period				: time		:= 10 ns;

	signal anode_sel				: STD_LOGIC_VECTOR( 3 downto 0 ) := ( others => '0' );
	signal CA,CB,CC,CD,CE,CF,CG		: STD_LOGIC := '0';

	-- uut
	component stopwatch 
		port(
			clk		: in STD_LOGIC;
			button	: in STD_LOGIC;

			anode_sel	: out STD_LOGIC_VECTOR( 3 downto 0 );
			CA,CB,CC	: out STD_LOGIC;
			CD,CE,CF,CG	: out STD_LOGIC
		);
	end component;


begin 

	-- Clk process
	clk_process : process
	begin
		clk_100MHz <= NOT( clk_100MHz );
		wait for clk_period/2;
	end process;

	-- uut
	uut : stopwatch
		port map( clk => clk_100MHz, button => button, anode_sel => anode_sel,
					CA => CA,
					CB => CB,
					CC => CC,
					CD => CD,
					CE => CE,
					CF => CF,
					CG => CG
				);
	
		
	--Stimulus
	stimulus : process
	begin

		
		
		button <= '1';
			wait for clk_period*1.3e6;
		button <= '0';
			wait for clk_period*1.5e6;
		wait for clk_period*1.5e6;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		button <= '1';
			wait for clk_period*1.5e6;
		button <= '0';
			wait for clk_period*1.5e6;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		button <= '1';
			wait for clk_period*1.5e6;
		button <= '0';
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait;
	end process;
end;

