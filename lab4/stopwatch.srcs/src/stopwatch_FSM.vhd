-----------------------------------------
-- Stopwatch top module
----------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- entity declaration
entity stopwatch_FSM is

	port(
			clk		: in STD_LOGIC;
			button	: in STD_LOGIC;

			value	: out STD_LOGIC_VECTOR( 15 downto 0 )
		);

end stopwatch_FSM;

architecture behaviour of stopwatch_FSM is

	-- Define a type to make FSM more readable
	type state_type is ( RESET, START, STOP );
	signal state : state_type := RESET;
	
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
	process( clk, state, button )
	begin
		if rising_edge( clk ) then
			case state is
				when RESET =>
					reset_counter <= '1';
					if button = '1' then
						state <= START;
					end if;

				when START =>
				
					reset_counter <= '0';
					enable <= '1';
					if button = '1' then
						state <= STOP;
					end if;
		
				when STOP => 
				
					enable <= '0';
					if button = '1' then
						state <= RESET;
					end if;

				when others =>

					state <= RESET;

			end case;
		end if;
	end process;
end behaviour;


