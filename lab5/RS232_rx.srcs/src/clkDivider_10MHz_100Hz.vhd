---------------------------------------------
-- Clk divider for correct baud smapling clk
---------------------------------------------

library IEEE;
library UNISIM;

use IEEE.STD_LOGIC_1164.all;
use UNISIM.vcomponents.all;


-- entity declaration
entity clk_divider is

	port(
			--inputs
			clk_100MHz		: in STD_LOGIC;

			--outputs
			clk_153_6_kHz	: out STD_LOGIC

		);
end clk_divider;

architecture behaviour of clk_divider is

	-- Signals
	constant counter_nbits	: integer := 10;
	constant baudRate		: integer := 9600;
	constant samplesPerBR	: integer := 16;

	signal value			: STD_LOGIC_VECTOR( counter_nbits-1 downto 0 ) := ( others => '0' );
	signal clkBuffer_I		: STD_LOGIC := '0';
	signal clkBuffer_O		: STD_LOGIC := '0';
	signal clk_153_6MHz		: STD_LOGIC := '0';
	signal reset			: STD_LOGIC := '0';
	signal locked			: STD_LOGIC := '0';
		
	-- nbit counter for clk division
	component sync_nbitCounter is
		generic( nbits	: integer := 8 ); -- Variable num of bits
		port(
				clk		: in STD_LOGIC;
				reset   : in STD_LOGIC;
				enable  : in STD_LOGIC;
				value	: out STD_LOGIC_VECTOR( (nbits-1) downto 0 )
			);
	end component;

	-- PLL
	component PLL_100MHz_to_153DOT6MHz is
		port(
				clk_in1	: in STD_LOGIC;
				clk_out1: out STD_LOGIC;
				locked	: out STD_LOGIC
			);
	end component;

	-- global clk buffer
	component bufg   
		port(
				I : in STD_LOGIC;
				O : out STD_LOGIC
			);
	end component;

begin

	-- Assign the output of the global clk buffer to the output of the entity
	clk_153_6_kHz <= clkBuffer_O;

	--Instantiate sub entities
	counter : sync_nbitCounter
		generic map( nbits => counter_nbits )
		port map( clk => clk_153_6MHz, value => value, reset => reset, enable => '1'  );

	clk_buffer : bufg
		port map( I => clkBuffer_I, O => clkBuffer_O);

	PLL : PLL_100MHz_to_153DOT6MHz
		port map( clk_in1 => clk_100MHz, clk_out1 => clk_153_6MHz, locked => locked );

	-- Divide the clock
	process( clk_153_6MHz, value )
	begin
		if rising_edge( clk_153_6MHz ) then
			if locked = '1' then
				if value < "00111110100" then -- 500
					clkBuffer_I <= '1';
					reset <= '0'; -- Start counter again
				elsif value < "01111101000" then -- 1000
					clkBuffer_I <= '0';
				else
					reset <= '1'; -- Reset counter for correct duty cycle
				end if;
			end if;
		end if;
	end process;

end behaviour;


		



