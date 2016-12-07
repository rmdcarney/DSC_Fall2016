---------------------------
-- RS232Decoder tb
---------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--tb entity
entity RS232RX_w_display_tb is
end RS232RX_w_display_tb;

architecture testbench of RS232RX_w_display_tb is

	-- Signals
	signal clk 				: STD_LOGIC := '0';
	constant clk_period		: time 		:= 10 ns;

	signal serial_in		: STD_LOGIC := '1';
	signal an				: STD_LOGIC_VECTOR( 3 downto 0 ) := ( others => '0' );
	signal CA, CB, CC, CD	: STD_LOGIC := '0';
	signal CE, CF, CG		: STD_LOGIC	:= '0';

	-- uut
	component RS232decoder_withDisplay is
	port( 
			clk			: in STD_LOGIC;
			serial_in	: in STD_LOGIC;

			an			: out STD_LOGIC_VECTOR( 3 downto 0 );
           	CA, CB, CC, CD, CE, CF, CG : out std_logic
		);
	end component;

begin

	-- Clk process
	clk_process : process
	begin 
		clk <= NOT( clk );
		wait for clk_period/2;
	end process;

	-- uut
	uut : RS232decoder_withDisplay
		port map(
					clk				=> clk,
					serial_in		=> serial_in,
					an				=> an,
           			CA				=> CA,
					CB 				=> CB,
           			CC				=> CC,
					CD 				=> CD,
           			CE				=> CE,
					CF 				=> CF,
					CG 				=> CG
		);

	-- Stimulus
	stimulus : process
	begin

		wait for clk_period;
		wait for clk_period;
	    	serial_in <= '0'; -- Start bit
		wait for clk_period*16;
			serial_in <= '1'; -- 0
		wait for clk_period*16;
			serial_in <= '0'; -- 1
		wait for clk_period*16;
			serial_in <= '1'; -- 2
		wait for clk_period*16;
			serial_in <= '1'; -- 3
		wait for clk_period*16;
			serial_in <= '0'; -- 4
		wait for clk_period*16;
			serial_in <= '1'; -- 5
		wait for clk_period*16;
			serial_in <= '0'; -- 6
		wait for clk_period*16;
			serial_in <= '1'; -- 7
		wait for clk_period*16;
		wait for clk_period*16;
		wait for clk_period;
	    	serial_in <= '0'; -- Start bit
		wait for clk_period*16;
			serial_in <= '0'; -- 0
		wait for clk_period*16;
			serial_in <= '0'; -- 1
		wait for clk_period*16;
			serial_in <= '0'; -- 2
		wait for clk_period*16;
			serial_in <= '0'; -- 3
		wait for clk_period*16;
			serial_in <= '1'; -- 4
		wait for clk_period*16;
			serial_in <= '1'; -- 5
		wait for clk_period*16;
			serial_in <= '1'; -- 6
		wait for clk_period*16;
			serial_in <= '1'; -- 7
		wait for clk_period*16;
					serial_in <= '0'; -- Give a faulty end bit

		wait for clk_period*16;
							serial_in <= '1'; -- 7

		wait for clk_period*23;
	    	serial_in <= '0'; -- Start bit
		wait for clk_period*16;
			serial_in <= '1'; -- 0
		wait for clk_period*16;
			serial_in <= '0'; -- 1
		wait for clk_period*16;
			serial_in <= '1'; -- 2
		wait for clk_period*16;
			serial_in <= '0'; -- 3
		wait for clk_period*16;
			serial_in <= '1'; -- 4
		wait for clk_period*16;
			serial_in <= '0'; -- 5
		wait for clk_period*16;
			serial_in <= '1'; -- 6
		wait for clk_period*16;
			serial_in <= '0'; -- 7
		wait for clk_period*16;
			serial_in <= '1';
		wait for clk_period*16;
		wait;
	end process;
end;
