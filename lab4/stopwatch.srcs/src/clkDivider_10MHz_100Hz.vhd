-----------------------------------------
-- Clk divider by 1e6
----------------------------------------

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
			clk_100Hz		: out STD_LOGIC

		);
end clk_divider;

architecture behaviour of clk_divider is

	-- Signals
	constant counter_nbits	: integer := 20;
	signal value			: STD_LOGIC_VECTOR( counter_nbits-1 downto 0 ) := ( others => '0' );
	signal clkBuffer_I		: STD_LOGIC := '0';
	signal clkBuffer_O		: STD_LOGIC := '0';

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

	-- global clk buffer
	component bufg
		port(
				I : in STD_LOGIC;
				O : out STD_LOGIC
			);
	end component;

begin

	-- Assign the output of the global clk buffer to the output of the entity
	clk_100Hz <= clkBuffer_O;

	--Instantiate sub entities
	counter : sync_nbitCounter
		generic map( nbits => counter_nbits )
		port map( clk => clk_100MHz, value => value, reset => '0', enable => '1'  );

	clk_buffer : bufg
		port map( I => clkBuffer_I, O => clkBuffer_O);

	-- Divide the clock
	process( clk_100MHz, value )
	begin
		if rising_edge( clk_100MHz ) then
			if value < "0111101000010010000" then
				clkBuffer_I <= '1';
			else
				clkBuffer_I <= '0';
			end if;
		end if;
	end process;

end behaviour;


		



