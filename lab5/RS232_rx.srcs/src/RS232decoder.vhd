-----------------------------------------
-- RS232Decoder FSM
----------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

-- entity declaration
entity RS232_decoder is

	port(
			clk			: in STD_LOGIC;
			serial_in	: in STD_LOGIC;

			parallel_out: out STD_LOGIC_VECTOR( 7 downto 0 )

		);
end RS232_decoder;

architecture arch of RS232_decoder is

	-- Sub-entity declaration
	component RS232decoder_FSM
	port(
			clk				: in STD_LOGIC;
			serial_in		: in STD_LOGIC;
			counter_in		: in STD_LOGIC_VECTOR( 3 downto 0 );

			shift_out		: out STD_LOGIC;
			shift_in		: out STD_LOGIC;
			counter_start	: out STD_LOGIC;
			counter_reset	: out STD_LOGIC
		);
	end component;

	component sync_nbitCounter
		generic( nbits : integer := 8 ); -- variable number of bits
		port(
				reset	: in STD_LOGIC;
				enable	: in STD_LOGIC;
				clk		: in STD_LOGIC;

				value	: out STD_LOGIC_VECTOR( nbits-1 downto 0 )
			);
	end component;

	component nbitSIPO_SR is
	generic( nbits : integer := 8 ); --Variable number of bits
    port ( 	           	
			-- Single-bit inputs
			serial_in 		: in STD_LOGIC;
			shift_in 		: in STD_LOGIC;
           	shift_out 		: in STD_LOGIC;	
			clk 			: in STD_LOGIC;

			-- Single-bit outputs
           	parallel_out 	: out STD_LOGIC_VECTOR ( (nbits-1) downto 0)
		 );
	end component;

	-- Signals
	signal shift_in, shift_out 			: STD_LOGIC := '0';
	signal counter_start, counter_reset : STD_LOGIC := '0';
	signal counter_value				: STD_LOGIC_VECTOR( 3 downto 0 ) := ( others => '0');
begin

	-- Connect ports and signals
	RS232_RX_FSM : RS232decoder_FSM
		port map(
			clk				=> clk,
			serial_in		=> serial_in,
			counter_in		=> counter_value,

			shift_out		=> shift_out,
			shift_in		=> shift_in,
			counter_start	=> counter_start,
			counter_reset	=> counter_reset
		);
					
	counter : sync_nbitCounter
	   generic map( nbits => 4 )
		port map(
			reset			=> counter_reset,
			enable			=> counter_start,
			clk				=> clk,

			value			=> counter_value
			);

	SIPO : nbitSIPO_SR
		port map(
			-- Single-bit inputs
			serial_in 		=> serial_in, 	
			shift_in 		=> shift_in,
           	shift_out 		=> shift_out,	
			clk 			=> clk,

			-- Single-bit outputs
           	parallel_out 	=> parallel_out
		 );

end arch;
