-----------------------------
-- nbit counter tb
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_unsigned.all;

-- Entity declaration
entity nbit_counter_tb is
end nbit_counter_tb;

architecture testbench of nbit_counter_tb is

    constant nbits_tb : integer := 8;
	
	--Signal definitions
	signal clk			: STD_LOGIC := '0';
	constant clk_period	: time		:= 10 ns;
	signal value		: STD_LOGIC_VECTOR( nbits_tb-1 downto 0 );
	
	-- UUT: nbit counter
	component nbit_counter
		generic( nbits 	: INTEGER := 8 );
		port(
				clk		: in STD_LOGIC;
				value	: out STD_LOGIC_VECTOR( nbits-1 downto 0)
			);
	end component;


begin

	-- Clk process
	clk_process : process
	begin
		clk <= not(clk);
		wait for clk_period/2;
	end process;

	
	-- UUT instantiation
	uut : nbit_counter
		generic map( nbits => nbits_tb )
		port map( clk => clk, value => value );


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
