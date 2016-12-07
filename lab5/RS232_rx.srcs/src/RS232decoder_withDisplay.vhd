-----------------------------------------
-- RS232Decoder FSM
----------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

-- entity declaration
entity RS232decoder_withDisplay is
	
	port(
			clk			: in STD_LOGIC;
			serial_in	: in STD_LOGIC;

			an			: out STD_LOGIC_VECTOR( 3 downto 0 );
           	CA, CB, CC, CD, CE, CF, CG : out std_logic;
			error		: out STD_LOGIC
		);
end RS232decoder_withDisplay;

architecture arch of RS232decoder_withDisplay is

	-- Sub-entity declaration
	component RS232_decoder
	port(
			clk 		: in STD_LOGIC;
			serial_in	: in STD_LOGIC;
			parallel_out: out STD_LOGIC_VECTOR( 7 downto 0 );
			error		: out STD_LOGIC
		);
	end component;

	component disp4
    Port (
           clk:       in std_logic;
           disp_in :  in  std_logic_vector(15 downto 0);
           an : out std_logic_vector (3 downto 0);
           CA, CB, CC, CD, CE, CF, CG : out std_logic);
	end component;

	-- Signals
	signal decoder_out		: STD_LOGIC_VECTOR( 7 downto 0 ) := ( others => '0');
	signal parallel_out		: STD_LOGIC_VECTOR( 15 downto 0 ) := ( others => '0' );

begin
	
	parallel_out <= "00000000" & decoder_out;

	-- Connect ports and signals
	RS232RX : RS232_decoder
		port map(
					clk 		=> clk,
					serial_in	=> serial_in,
					parallel_out=> decoder_out,
					error		=> error
				);
	
	display : disp4
		port map(
					clk			=> clk,
					disp_in		=> parallel_out,
					an			=> an,
					CA			=> CA,
					CB			=> CB,
					CC			=> CC,
					CD			=> CD,
					CE			=> CE,
					CF			=> CF,
					CG			=> CG
				);

end arch;
