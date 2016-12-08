-------------------------------------------------
-- 	synchrnous signed 16bit counter w/ reset
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

-- entity declaration
entity signed_nbitCounter is

	generic(   nbits : integer := 8; -- variable number of bits
	           upperBound : signed := "01111111"; -- Use full range of counter by default
               lowerBound : signed := "10000000");
	port(
			reset	: in STD_LOGIC;
			clk		: in STD_LOGIC;

			value	: out STD_LOGIC_VECTOR( nbits-1 downto 0 )
	);

end signed_nbitCounter;

architecture counter_arch of signed_nbitCounter is

	-- Repeat N values of B
	function repeat(N: natural; B: std_logic) return signed
		is
			variable result: signed(1 to N);
			begin
				for i in 1 to N loop
					result(i) := B;
				end loop;
			return result;
	end;

	-- The counter will increment with unsigned arithmetic
	signal counter	: SIGNED( nbits-1 downto 0 ) := lowerBound; -- nbits, at overflow we want reset
	
begin

	count : process( clk, reset )
	begin
		if rising_edge( clk ) then
			if reset = '1' then
				counter <= lowerBound; -- synchronous reset
			else
				if counter < upperBound then
						counter <= counter + '1';
				else
						counter <= lowerBound;
				end if;
			end if;
		end if;
	end process;

	value <= STD_LOGIC_VECTOR(counter); --Connect internal counter to output port

end counter_arch;
		
				
