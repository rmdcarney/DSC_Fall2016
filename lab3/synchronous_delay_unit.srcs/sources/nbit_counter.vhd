-------------------------------------------------
-- 	nbit counter
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- entity declaration
entity nbit_counter is

	generic( nbits	: integer := 8 ); -- Variable num of bits

	port(
			clk		: in STD_LOGIC;
			value	: out STD_LOGIC_VECTOR( (nbits-1) downto 0 )
	);

end nbit_counter;

architecture counter_arch of nbit_counter is

	-- The counter will increment with unsigned arithmetic
	signal counter	: UNSIGNED( nbits-1 downto 0 ) := ( others => '0' ); -- nbits, at overflow we want reset
	
begin

	count : process( clk )
	begin
		if rising_edge( clk ) then
			counter <= counter + '1';
		end if;
	end process;

	value <= STD_LOGIC_VECTOR(counter); --Connect internal counter to output port

end counter_arch;
		
				
