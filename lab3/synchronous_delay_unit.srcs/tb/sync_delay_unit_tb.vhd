--------------------------------------------------------
-- Top level design: synchronous delay unit with DP_RAM
--------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library blk_mem_gen_v8_3_3;

-- entity declaration
entity sync_delay_unit_tb is
end sync_delay_unit_tb;

architecture testbench of sync_delay_unit_tb is

	--Signal definition
	signal clk				: STD_LOGIC := '0';
	constant clk_period		: time		:= 10 ns;
	
	signal offset			: STD_LOGIC_VECTOR( 7 downto 0 ) := ( others => '0' );
	signal data_out           : STD_LOGIC_VECTOR( 3 downto 0 ) := ( others => '0' );

	-- uut 
	component sync_delay_unit
	port( 
			-- inputs
			clk 		: in STD_LOGIC;
			offset		: in STD_LOGIC_VECTOR( 7 downto 0 );

			-- outputs
			data_out	: out STD_LOGIC_VECTOR( 3 downto 0 )
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
	uut : sync_delay_unit
		port map( clk => clk, offset => offset, data_out => data_out );


	-- Stimulus
	stimulus : process
	begin

		offset <= "00000010";
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

