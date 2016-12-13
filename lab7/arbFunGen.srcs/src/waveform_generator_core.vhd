---------------------------------------
-- Waveform gen. core
---------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

-- entity declaration
entity waveformGen_core is

	-- TODO Make generic for frequency
	port(
			-- Wave selection switches (could be switched to button press)
			select_square 	: in STD_LOGIC;
			select_triangle	: in STD_LOGIC;
			select_sine		: in STD_LOGIC;
			
			clk				: in STD_LOGIC;
			x				: in STD_LOGIC_VECTOR( 7 downto 0 );
			fx				: out STD_LOGIC_VECTOR( 7 downto 0 )
		);

end waveformGen_core;

architecture waveform_generator of waveformGen_core is 

	-- Square wave
	function squareWave( x : STD_LOGIC_VECTOR( 7 downto 0 )) 
	return STD_LOGIC_VECTOR( 7 downto 0 ) is
		
		variable result : STD_LOGIC_VECTOR( 7 downto 0 );

		begin

			if signed(x) < 0 then
				result = ( others <= '0');
			else
				result = ( others <= '1');
			end if;
		return result;
	end; -- function

begin

	genWave : process( clk, select_square, select_triange, select_sine )
	begin
		if rising_edge( clk ) then
			if select_square = '1' then
				fx <= squareWave( x );
			end if;
		end if;
	end process;



end waveform_generator;
