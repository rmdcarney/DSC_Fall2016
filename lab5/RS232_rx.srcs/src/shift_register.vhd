----------------------------------------------------------------------------------
---===== SIPO SR =====
-- This is a clked, enabled SR. It will only shift on both a rising clk edge
-- and a shift_in = '1'.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nbitSIPO_SR is

	generic( nbits : integer := 8 ); --Variable number of bits
    port ( 	           	
			-- Single-bit inputs
			serial_in 		: in STD_LOGIC;
			shift_in 		: in STD_LOGIC;
           	shift_out 		: in STD_LOGIC;	
			clk 			: in STD_LOGIC;

			-- Single-bit outputs
           	parallel_out 	: out STD_LOGIC_VECTOR ( (nbits-1) downto 0)
		 );

end nbitSIPO_SR;

architecture arch of SIPO_SR is

    signal SR_content : STD_LOGIC_VECTOR ( (nbits-1) downto 0 ) := ( others => '0' ); -- n+1 bits, to store output state
    
begin

	process ( clk, shift_in, shift_out )
	begin
	
		if rising_edge( clk ) then
			
			if ( shift_in = '1' ) then --Shift
				
				SR_content( nbits-1 downto 0 ) <= serial_in & SR_content( nbits-1 downto 1 );
			
			end if;

			if ( shift_out = '1' ) then -- copy parallel input into SR
					parallel_out <= SR_content( nbits-1 downto 0  );
			end if;
		end if; 
	end process;

end arch;
