-----------------------------------------
-- 4-bit PRNG (16-bit circular SR)
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- entity declaration
entity prng_4bit is

	port(
			clk		: in STD_LOGIC;
			random	: out STD_LOGIC_VECTOR ( 3 downto 0 )
		);
end prng_4bit;

architecture prng4bit_arch of prng_4bit is 

	component prng
		generic( init_seed : STD_LOGIC_VECTOR ( 15 downto 0 ) := "0101110110010101");
		port(
				clk		: in STD_LOGIC;
				random	: out STD_LOGIC
			);
	end component;

begin
		prng_0 : prng
			generic map ( init_seed => "1001011001111001")
			port map ( clk => clk, random => random( 0 ));

		prng_1 : prng
			generic map ( init_seed => "0011100100100011")
			port map ( clk => clk, random => random( 1 ));

		prng_2 : prng
			generic map ( init_seed => "1111111101010111")
			port map ( clk => clk, random => random( 2 ));

		prng_3 : prng
			generic map ( init_seed => "1101001110010110")
			port map ( clk => clk, random => random( 3 ));

end prng4bit_arch;
	
