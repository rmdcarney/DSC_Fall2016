-----------------------------------------------------------
-- PRNG_4bit TB
-----------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_unsigned.all;

-- Entity declaration
entity prng_4bit_tb is
end prng_4bit_tb;

architecture testbench of prng_4bit_tb is 

	-- UUT: 4bit prng
	component prng_4bit
		port( 
				clk 		: in STD_LOGIC;
				random		: out STD_LOGIC_VECTOR ( 3 downto 0 )
			);
	end component;

	--Signal definitions
	signal clk			: STD_LOGIC := '0';
	constant clk_period : time 		:=  10 ns;
	signal random		: STD_LOGIC_VECTOR (3 downto 0 );

begin

	-- Clk process
	clk_process : process
	begin
		clk <= not(clk);
		wait for clk_period/2;
	end process;

	
	-- UUT instantiation
	uut : prng_4bit
		port map( clk => clk, random => random );

	
	-- Stimulus
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
		wait;
	end process;

end;
