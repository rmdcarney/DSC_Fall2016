----------------------------------------------------------------------------------
-- nbit adder
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nbit_adder is
	
	generic ( nbits: integer := 8 ); -- Variable number of bits, 4 by default

    Port ( 	a_in : in STD_LOGIC_VECTOR ( nbits-1 downto 0);
           	b_in : in STD_LOGIC_VECTOR ( nbits-1 downto 0);
           	sum_out : out STD_LOGIC_VECTOR ( nbits-1 downto 0);
           	carry_in : in STD_LOGIC;
           	carry_out : out STD_LOGIC	
		 );

end nbit_adder;

architecture Behavioral of nbit_adder is

	component full_adder
	
		Port(	a : in STD_LOGIC;
				b : in STD_LOGIC;
            	carry_in : in STD_LOGIC;
            	sum : out STD_LOGIC;
            	carry_out : out STD_LOGIC
			);
	
	end component;


    for all : full_adder use entity work.full_adder;
    
    signal carry : STD_LOGIC_VECTOR ( nbits+1 downto 0 ) := ( others => '0' );
    
begin

	GEN_ADDERS: for i in 0 to nbits-1 generate    	
		adder_i: full_adder
        	port map ( a => a_in( i ), b => b_in( i ), carry_in => carry( i ), sum => sum_out( i ), carry_out => carry( i+1 ));
	end generate GEN_ADDERS;
    
    carry( 0 ) <= carry_in;
    carry_out <= carry( nbits );


end Behavioral;
