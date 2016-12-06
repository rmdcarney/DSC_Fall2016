-----------------------------------------
-- RS232Decoder FSM
----------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- entity declaration
entity RS232decoder_FSM is

	port(
			clk				: in STD_LOGIC;
			serial_in		: in STD_LOGIC;
			counter_in		: in STD_LOGIC_VECTOR( 3 downto 0 );

			shift_out		: out STD_LOGIC;
			shift_in		: out STD_LOGIC;
			counter_start	: out STD_LOGIC;
			counter_reset	: out STD_LOGIC

		);

end RS232decoder_FSM;

architecture arch of RS232decoder_FSM is

	-- Define type to make FSM more readable
	type state_type is ( WAIT_FOR_START, CENTERING, SAMPLE, STOP );
	signal state : state_type := WAIT_FOR_START;

begin

	--FSM
	process( clk, serial_in, counter_in )
		variable loopIterator : unsigned( 3 downto 0 ) := ( others => '0' );
	begin
		if rising_edge( clk ) then
			
			case state is 
				when WAIT_FOR_START =>
					
					-- Don't count or shift
					counter_reset <= '1';
					shift_in      <= '0';
					shift_out      <= '0';
					
					-- Edge detect start bit
					if serial_in = '0' then
						counter_start <= '1'; -- Start counting to reach middle of bit
						state <= CENTERING;
					end if;

				when CENTERING => 

					-- Aligned to centre, taking edge detect latency into account
					if counter_in = "0110" then
						counter_reset <= '1'; -- Reset counter halfway through window
						state <= SAMPLE;
					end if;
					
				when SAMPLE =>

					counter_reset <= '0'; -- Counter will rollover throughout this state

					-- Sample data after 16 counts
					if counter_in = "1111" then
							loopIterator := loopIterator + 1;
							shift_in <= '1';
					end if;
					
					-- Turn off samplign for another 16 clk cycles
					if counter_in = ( others => '0' ) then 	
					 	shift_in <= '0';
					end if;

					-- Sample for n data bits (n = 8)
					if loopIterator = "1000" then
					 	state <= STOP;
						shift_out <= '1'; -- All data now sampled, so shift out
					end if;


				when STOP => 
					
					-- Count to halfway through stop bit(s) and then go back to start
					if counter_in = "1111" then
						counter_reset <= '1';
						state <= WAIT_FOR_START;
					end if;

				when others =>

					state <= WAIT_FOR_START;

			end case;
		end if;
	end process;
end arch;

