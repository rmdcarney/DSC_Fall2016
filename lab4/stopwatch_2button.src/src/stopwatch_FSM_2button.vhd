-----------------------------------------
-- Stopwatch FSM
----------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- entity declaration
entity stopwatch_FSM_2button is

	port(
			clk					: in STD_LOGIC;
			button_startStop	: in STD_LOGIC;
			button_reset		: in STD_LOGIC;

			value				: out STD_LOGIC_VECTOR( 15 downto 0 )
		);

end stopwatch_FSM_2button;

architecture behaviour of stopwatch_FSM_2button is

	-- Define a type to make FSM more readable
	type state_type is ( START, STOP );
	signal state : state_type := STOP;
	
	-- Internal component
	signal reset_counter, enable 	: STD_LOGIC := '0';
	signal counter_value	: STD_LOGIC_VECTOR( 15 downto 0 ) := ( others => '0' );

	component sync_16bCounter is
		port(
			reset	: in STD_LOGIC;
			enable	: in STD_LOGIC;
			clk		: in STD_LOGIC;

			value	: out STD_LOGIC_VECTOR( 15 downto 0 )
			);
	end component;

begin

	-- The output port is always set to the value of the internal counter
	value <= counter_value;	

	-- Instantiate sub-entity
	counter : sync_16bCounter
		port map( clk => clk, reset => reset_counter, enable => enable, value => counter_value );

	-- FSM
	process( clk, state, button_startStop, button_reset )
	begin
		if rising_edge( clk ) then
		
				if button_reset = '1' then
					reset_counter <= '1';
				else
					reset_counter <= '0';
				end if;
			
			case state is
				when STOP =>
					if button_startStop = '1' then
						state <= START;
						enable <= '1';
					end if;
					
				when START =>
				
					if button_startStop = '1' then
						state <= STOP;
						enable <= '0';
					end if;
			end case;
		end if;
	end process;
end behaviour;


