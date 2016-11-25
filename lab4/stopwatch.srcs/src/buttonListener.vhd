--------------------------------------------------------------
-- Button listener for stopwatch
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity button_listener is

	port (
			-- Inputs
			clk		: in STD_LOGIC;
			button 	: in STD_LOGIC;
		
			-- Outputs
			output	: out STD_LOGIC
		);

end button_listener;

architecture behaviour of button_listener is

	-- Define a type to make the FSM more readable
	type state_type is ( NOT_PRESSED, PRESSED, HELD );
	signal state : state_type := NOT_PRESSED;


-- TODO should this all be clocked logic? 
-- The problem is that it relies on the user holding on for a certain amount. 
-- It would be an error of 10 ms for a 100 Hz clock.

begin 

	process( clk, state, button )
	begin

		case state is
			when NOT_PRESSED =>
				
				output <= '0';
				-- Button listener is synchronous
				if rising_edge( clk ) then
					if button = '1' then
					
					    output <= '1';
						state <= PRESSED; -- Clk the state transition to make sure event stays high for at least one clk cycle
					
					end if;
				end if;
			
			when PRESSED =>

				if rising_edge( clk ) then
					
					output <= '0';
					if button = '1' then
						state <= HELD;
					else
						state <= NOT_PRESSED;
					end if;

				end if;

			when HELD =>

				if button = '0' then
					state <= NOT_PRESSED;
				end if;

		end case;
	end process;
end behaviour;



