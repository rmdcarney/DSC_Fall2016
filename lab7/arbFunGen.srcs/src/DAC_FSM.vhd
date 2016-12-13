-----------------------------------------
-- DAC FSM
----------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.all;
--use IEEE.STD_LOGIC_ARITH.all;
--use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;

-- entity declaration
entity DAC_FSM is

	port(
			clk				: in STD_LOGIC;
			fx				: in STD_LOGIC;
			controller_DONE	: in STD_LOGIC_VECTOR( 7 downto 0);

			controller_rst	: out STD_LOGIC;
			counter_enable	: out STD_LOGIC;
			channel_0		: out STD_LOGIC_VECTOR( 7 downto 0);
			channel_1		: out STD_LOGIC;
		);

end DAC_FSM;

architecture FSM_arch of DAC_FSM is

	-- Define type to make FSM more readable
	type state_type is ( WAIT_FOR_DONE, DAC_WRITE);
	signal state : state_type := WAIT_FOR_DONE;
	
	-- Store fx
	signal fx_state : in STD_LOGIC_VECTOR( 7 downto 0 ) := ( others <= '0');

begin

	channel_0 <= fx_state;
	channel_1 <= fx_state;
	
	--FSM
	process( clk, controller_DONE )
	begin
		if falling_edge( clk ) then
			
			case state is 
				when WAIT_FOR_DONE => -- This state lasts until the DAC write is finished
					
					controller_rst <= '0'; -- Finish write process

					if controller_DONE = '1' then 
						state <= DAC_WRITE; 
						fx_state <= fx; -- Copy waveform gen output
						counter_enable <= '1'; -- Increment counter
					end if;

				when DAC_WRITE => -- This state only lasts one clk cycle 

					counter_enable <= '0';
					controller_rst <= '1'; -- Begin write process
					state <= WAIT_FOR_DONE;

				when others =>
					
					state <= WAIT_FOR_DONE;

			end case;
		end if;
	end process;
end arch;

