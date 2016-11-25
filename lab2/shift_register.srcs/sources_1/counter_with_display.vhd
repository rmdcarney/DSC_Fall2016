----------------------------------------------------------------------------------
-- SR TB
----------------------------------------------------------------------------------

library IEEE;
USE ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration 
entity counter_with_display is    
	port ( 	
			-- Inputs
			clk     	: in STD_LOGIC;
			a			: in STD_LOGIC_VECTOR ( 3 downto 0 );
			b			: in STD_LOGIC_VECTOR ( 3 downto 0 );

			-- Outputs
			sel			: out STD_LOGIC_VECTOR (3 downto 0 );
			CA,CB,CC	: out STD_LOGIC;
			CD,CE,CF,CG	: out STD_LOGIC

		);
end counter_with_display;


architecture Behavioural of counter_with_display is

	--==== SIGNALS ====
	
	-- Mode control
	signal sum			: STD_LOGIC_VECTOR( 3 downto 0 ) := ( others => '0' );
	signal disp_in		: STD_LOGIC_VECTOR( 15 downto 0) := ( others => '0' );

	--=== Components in top =====

	-- shift register for serializer/deserializer
	component bit_serial_adder
		port ( 
			--  inputs
			clk 			: in STD_LOGIC;
			a		 		: in STD_LOGIC_VECTOR ( 3 downto 0 );
			b		 		: in STD_LOGIC_VECTOR ( 3 downto 0 );

			--  outputs
			sum		 		: out STD_LOGIC_VECTOR( 3 downto 0 )
		 );
    end component;

	--Four digit, seven segment display on Basys3 board
	component disp4
		port (

			-- Inputs
			clk				: in STD_LOGIC;
			disp_in			: in STD_LOGIC_VECTOR( 15 downto 0 );

			-- Outputs
			an				: out STD_LOGIC_VECTOR( 3 downto 0 ); -- Anodes for each digit (sel)
			CA, CB, CC, CD	: out STD_LOGIC; -- 4 of seven segments 
			CE, CF, CG		: out STD_LOGIC -- 3 of seven segments (see Basys3 user manual)
		);
	end component;

begin 

	-- 4-bit counter so we only need the first 4 digits
	disp_in <= "000000000000" & sum;

	-- Connect ports and signals
	fourBit_adder : bit_serial_adder
		port map (
			a 				=> a,	
           	b 				=> b,
           	clk		 			=> clk,
           	
			sum					=> sum
		);

   display : disp4
		port map (
			clk => clk,
			disp_in => disp_in,

			an => sel,
			CA => CA,
			CB => CB,
			CC => CC,
			CD => CD,
			CE => CE,
			CF => CF,
			CG => CG
		);
			

end Behavioural;

