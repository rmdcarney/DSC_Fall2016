--------------------------------------------------------
-- Top level design: synchronous delay unit with DP_RAM
--------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library blk_mem_gen_v8_3_3;
use blk_mem_gen_v8_3_3.blk_mem_gen_v8_3_3;

-- entity declaration
entity sync_delay_unit is

	port( 
			-- inputs
			clk 		: in STD_LOGIC;
			offset		: in STD_LOGIC_VECTOR( 7 downto 0 );
			data_in		: in STD_LOGIC_VECTOR( 3 downto 0 );

			-- outputs
			data_out	: out STD_LOGIC_VECTOR( 3 downto 0 );
		);

end sync_delay_unit;			












ENTITY dualPortRAM_8b_2048 IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END dualPortRAM_8b_2048;
