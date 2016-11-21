-----------------------------------------
-- single-bit PRNG (16-bit circular SR)
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


--entity declaration
entity prng is

	generic( init_seed : STD_LOGIC_VECTOR ( 15 downto 0 ) := "0101110110010101");

	port( 
			clk		: in STD_LOGIC;
			random	: out STD_LOGIC
		);

end prng;

architecture prng_arch of prng is
	
	signal seed : STD_LOGIC_VECTOR (15 downto 0 ) := init_seed;

begin

		gen_number : process( clk )
		begin

			if rising_edge( clk ) then
				seed <= seed(14 downto 0) & ( seed(15) xor seed(13) xor seed(12) xor seed(10) );
			end if;
		end process;

		random <= seed(15);

end architecture;


