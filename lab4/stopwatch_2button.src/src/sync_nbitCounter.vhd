-------------------------------------------------
-- 	synchrnous 16bit counter w/ reset
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- entity declaration
entity sync_nbitCounter is

	generic( nbits : integer := 8 ); -- variable number of bits
	port(
			reset	: in STD_LOGIC;
			enable	: in STD_LOGIC;
			clk		: in STD_LOGIC;

			value	: out STD_LOGIC_VECTOR( nbits-1 downto 0 )
	);

end sync_nbitCounter;

architecture counter_arch of sync_nbitCounter is

	-- The counter will increment with unsigned arithmetic
	signal counter	: UNSIGNED( nbits-1 downto 0 ) := ( others => '0' ); -- nbits, at overflow we want reset
	
begin

	count : process( clk, reset, enable )
	begin
		if rising_edge( clk ) then
			if reset = '1' then
				counter <= ( others => '0' ); -- synchronous reset
			elsif enable = '1' then
				counter <= counter + '1';
			end if;
		end if;
	end process;

	value <= STD_LOGIC_VECTOR(counter); --Connect internal counter to output port

end counter_arch;
		
				
