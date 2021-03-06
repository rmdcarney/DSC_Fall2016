---------------------------
-- RS232Decoder FSM tb
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--tb entity
entity RS232decoder_FSM_tb is
end RS232decoder_FSM_tb;

architecture testbench of RS232decoder_FSM_tb is

	-- Signals
	signal clk				: STD_LOGIC := '0';
	constant clk_period		: time 		:= 10 ns; -- 100 MHz

	signal serial_in		: STD_LOGIC := '1'; -- Active low
	signal counter_value	: STD_LOGIC_VECTOR( 3 downto 0 ) := ( others => '0');

	signal shift_out		: STD_LOGIC := '0';
	signal shift_in			: STD_LOGIC := '0';
	signal counter_start	: STD_LOGIC := '0';
	signal counter_reset	: STD_LOGIC := '0';

	-- uut
	component RS232decoder_FSM
	port (
			clk				: in STD_LOGIC;
			serial_in		: in STD_LOGIC;
			counter_in		: in STD_LOGIC_VECTOR( 3 downto 0 );

			shift_out		: out STD_LOGIC;
			shift_in		: out STD_LOGIC;
			counter_start	: out STD_LOGIC;
			counter_reset	: out STD_LOGIC

		);
	end component;

	-- Support
	component sync_nbitCounter
		generic( nbits : integer := 8 ); -- variable number of bits
		port(
				reset	: in STD_LOGIC;
				enable	: in STD_LOGIC;
				clk		: in STD_LOGIC;

				value	: out STD_LOGIC_VECTOR( nbits-1 downto 0 )
			);
	end component;


begin

	-- Clk process
	clk_process : process
	begin
		clk <= NOT( clk );
		wait for clk_period/2;
	end process;

	-- counter
	counter_4bit : sync_nbitCounter
		generic map( nbits => 4 )
		port map(
				 	reset			=> counter_reset,
				 	enable			=> counter_start,
					clk 			=> clk,
					value			=> counter_value
				);

	-- uut
	uut : RS232decoder_FSM
		port map( 
					clk				=> clk,
					serial_in		=> serial_in,
					counter_in		=> counter_value,
	
					shift_out		=> shift_out,
					shift_in		=> shift_in,
					counter_start	=> counter_start,
					counter_reset	=> counter_reset

				);
	-- Stimulus
	stimulus : process
	begin


		wait for clk_period;
		wait for clk_period;
	    	serial_in <= '0'; -- Start bit
		wait for clk_period*16;
			serial_in <= '1'; -- 0
		wait for clk_period*16;
			serial_in <= '0'; -- 1
		wait for clk_period*16;
			serial_in <= '1'; -- 2
		wait for clk_period*16;
			serial_in <= '1'; -- 3
		wait for clk_period*16;
			serial_in <= '0'; -- 4
		wait for clk_period*16;
			serial_in <= '1'; -- 5
		wait for clk_period*16;
			serial_in <= '0'; -- 6
		wait for clk_period*16;
			serial_in <= '1'; -- 7
		wait for clk_period*16;
		wait for clk_period*16;
		wait;
	end process;
end;
