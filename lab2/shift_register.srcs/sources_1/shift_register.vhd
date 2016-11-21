----------------------------------------------------------------------------------
--- Flexible SIPO/PISO SR
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
	
    Port ( 	           	
			-- Single-bit inputs
			serial_in 		: in STD_LOGIC;
			shift_in 		: in STD_LOGIC;
           	shift_out 		: in STD_LOGIC;	
			clk 			: in STD_LOGIC;
			parallel_in 	: in STD_LOGIC_VECTOR ( 3 downto 0);

			-- Single-bit outputs
			serial_out 		: out STD_LOGIC;
           	parallel_out 	: out STD_LOGIC_VECTOR ( 3 downto 0)
		 );

end shift_register;

architecture Behavioral of shift_register is

    signal SR_content : STD_LOGIC_VECTOR ( 3 downto 0 ) := ( others => '0' ); -- n+1 bits, to store output state
    
begin

	process ( clk, shift_in, shift_out )
	begin
	
		
		-- Clocked logic
		if rising_edge( clk ) then
			
			if ( shift_in = '0' ) then --Shift
				
				SR_content( 3 downto 0 ) <= serial_in & SR_content( 3 downto 1 );
			
			elsif ( shift_in = '1' ) then
				SR_content( 3 downto 0 ) <= parallel_in; 
			
			end if;

			if ( shift_out = '1' ) then -- copy parallel input into SR
					parallel_out <= SR_content( 3 downto 0  );
			end if;
		end if; --trigger			
	end process;

    serial_out <= SR_content( 0 ); -- Not clocked


end Behavioral;
