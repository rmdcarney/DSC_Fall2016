--------------------------------------------------------
-- Top level design: synchronous delay unit with DP_RAM
--------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library blk_mem_gen_v8_3_3;

-- entity declaration
entity sync_delay_unit is

	port( 
			-- inputs
			clk 		: in STD_LOGIC;
			offset		: in STD_LOGIC_VECTOR( 7 downto 0 );

			-- outputs
			data_out	: out STD_LOGIC_VECTOR( 3 downto 0 )
		);

end sync_delay_unit;			


architecture syncDelay_arch of sync_delay_unit is

	signal sum			: UNSIGNED( 7 downto 0 ) 		:= ( others => '0' );	
	signal counter		: STD_LOGIC_VECTOR(7 downto 0)	:= ( others => '0' );
	signal data_in		: STD_LOGIC_VECTOR( 3 downto 0)	:= ( others => '0' );

	component dualPortRAM_8b_2048
		port(
    			clka 	: IN STD_LOGIC;
    			addra 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    			dina 	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    			clkb 	: IN STD_LOGIC;
    			wea     : IN STD_LOGIC_VECTOR(0 downto 0);
    			addrb 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    			doutb 	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  			);
	end component;

	component nbit_counter 
		generic( nbits	: integer := 8 );
		port( 
				clk		: in STD_LOGIC;
				value	: out STD_LOGIC_VECTOR( nbits-1 downto 0 )  
			);
	end component;

	component prng_4bit
		port(
				clk		: in STD_LOGIC;
				random	: out STD_LOGIC_VECTOR( 3 downto 0 )
		);
	end component;

begin

	sum <= UNSIGNED( offset ) + UNSIGNED(counter);

	count :	nbit_counter
		generic map ( nbits => 8 )
		port map ( clk => clk, value => counter );

	ram	: dualPortRAM_8b_2048
		port map(
					clka 	=> clk,
					clkb 	=> clk,
					wea  	=> "1", -- For some reason we always need this
					addra	=> STD_LOGIC_VECTOR( sum ),
					addrb	=> counter,
					dina	=> data_in,
					doutb	=> data_out

				);

	prng : prng_4bit
		port map(
					clk		=> clk, 
					random 	=> data_in
				);


end syncDelay_arch;
