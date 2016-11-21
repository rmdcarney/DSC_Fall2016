----------------------------------------------------------------------------------
-- Full adder
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
	
    Port ( 	
			
			a_in 		: in STD_LOGIC;
           	b_in 		: in STD_LOGIC;
           	sum_out 	: out STD_LOGIC;
           	carry_in 	: in STD_LOGIC;
           	carry_out 	: out STD_LOGIC	
		 );

end full_adder;

architecture Behavioral of full_adder is

    signal carry: STD_LOGIC_VECTOR ( 1 downto 0 ) := ( others => '0' );
    signal mid_sum : STD_LOGIC := '0';

begin

	mid_sum 	<= 	a_in XOR b_in;
	carry( 0 ) 	<= 	a_in AND b_in;

	carry( 1 ) 	<= 	mid_sum AND carry_in;
	sum_out 		<= 	mid_sum XOR carry_in;
	carry_out 	<= 	carry( 0 ) OR carry( 1 );


end Behavioral;
