--------------------------
-- Stopwatch: top module
--------------------------

library IEEE;
library UNISIM;

use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use UNISIM.vcomponents.all;

-- entity declaration
entity stopwatch is 

	port( 
			clk		: in STD_LOGIC;
			button	: in STD_LOGIC;

			anode_sel	: out STD_LOGIC_VECTOR( 3 downto 0 );
			CA,CB,CC	: out STD_LOGIC;
			CD,CE,CF,CG	: out STD_LOGIC
		);

end stopwatch;

architecture behaviour of stopwatch is

	-- Signals
	signal clk_100Hz, button_press	: STD_LOGIC := '0';
	signal display_input			: STD_LOGIC_VECTOR( 15 downto 0 );

	-- Internal components
	component stopwatch_FSM is
		port(
				clk		: in STD_LOGIC;
				button	: in STD_LOGIC;
				value	: out STD_LOGIC_VECTOR( 15 downto 0 )
			);
	end component;

	component button_listener is
		port(
				clk		: in STD_LOGIC;
				button	: in STD_LOGIC;
				output	: out STD_LOGIC
			);
	end component;

	component clk_divider is
		port(
				clk_100MHz	: in STD_LOGIC;
				clk_100Hz	: out STD_LOGIC
			);
	end component;

	component disp4 is
		port(
				clk			: in STD_LOGIC;
				disp_in		: in STD_LOGIC_VECTOR( 15 downto 0);
				an			: out STD_LOGIC_VECTOR( 3 downto 0 );
				CA,CB,CC,CD	: out STD_LOGIC;
				CE,CF,CG	: out STD_LOGIC
			);
	end component;

begin 

	-- Connect ports and signals
	press_detect : button_listener
		port map( 
					clk 	=> clk_100Hz,
					button	=> button,
					output	=> button_press
				);
	
	clk_100M_to_100 : clk_divider
		port map(
					clk_100MHz 	=> clk,
					clk_100Hz  	=> clk_100Hz
				);

	stopwatch_logic	: stopwatch_FSM
		port map(
					clk 	=> clk_100Hz,
					button	=> button_press,
					value	=> display_input
				);

	display : disp4
		port map(
					clk			=> clk,
					disp_in		=> display_input,
					an			=> anode_sel,
					CA => CA,
					CB => CB,
					CC => CC,
					CD => CD,
					CE => CE,
					CF => CF,
					CG => CG
				);
end behaviour;

	
