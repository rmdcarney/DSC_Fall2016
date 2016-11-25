----------------------------------------------------------------------------------
-- SR TB
----------------------------------------------------------------------------------

library IEEE;
USE ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration 
entity bit_serial_adder is    
	port ( 	
			-- Inputs
			a		: in STD_LOGIC_VECTOR ( 3 downto 0 );
			b		: in STD_LOGIC_VECTOR ( 3 downto 0 );
			clk     : in STD_LOGIC;

			-- Outputs
			sum		: out STD_LOGIC_VECTOR (3 downto 0 )

		);
end bit_serial_adder;


architecture Behavioural of bit_serial_adder is

	--==== SIGNALS ====
	
	
	-- Mode control
	signal shift_in_ctrl, shift_out_ctrl, reset_ctrl	: STD_LOGIC := '0';
	
	-- Serialised inputs 
	signal serial_a, serial_b							: STD_LOGIC := '0';

	-- Adder signals and D-flipflop
	signal carry_in, carry_out, serial_sum, Q			: STD_LOGIC := '0';


	--=== Components in top =====

	-- shift register for serializer/deserializer
	component shift_register
		port ( 
			--  inputs
			serial_in 		: in STD_LOGIC;
			shift_in 		: in STD_LOGIC;
           	shift_out 		: in STD_LOGIC;	
			parallel_in 	: in STD_LOGIC_VECTOR ( 3 downto 0);
			clk 			: in STD_LOGIC;

			--  outputs
			serial_out 		: out STD_LOGIC;
           	parallel_out 	: out STD_LOGIC_VECTOR ( 3 downto 0)
		 );
    end component;

	-- mode control to cycle through latch, copy, reset
	component mode_control
		port (
			-- Inputs
			clk				: in STD_LOGIC;

			-- Outputs
			shift_in_ctrl	: out STD_LOGIC;
			shift_out_ctrl	: out STD_LOGIC;
			reset_ctrl		: out STD_LOGIC

		);
	end component;

	-- Single bit full adder (adds serialised input)
	component full_adder
		port (
			
			-- Inputs
			a_in 			: in STD_LOGIC;
           	b_in 			: in STD_LOGIC;
           	carry_in 		: in STD_LOGIC;
           	
			-- Outputs
			sum_out 		: out STD_LOGIC;
           	carry_out 		: out STD_LOGIC	
		 
		);
	end component;

begin 

	-- Delayed carry_out is sent back to carry_in
	carry_in <= Q;

	-- Store the carry_out from previous addition
	update_carry : process( clk, reset_ctrl )
	begin
		if rising_edge( clk ) then

			if reset_ctrl = '1' then
				Q <= '0';
			else
				Q <= carry_out;
			end if;
		end if;
	end process;

	-- Connect ports and signals
	-- Parallel In Serial Out a
	PISO_a : shift_register
		port map ( 
				serial_in 		=> '0', -- Do not use SI mode
				shift_in 		=> shift_in_ctrl,
				shift_out		=> '0', -- Do not use PO mode
				parallel_in		=> a,
				clk 			=> clk,

				serial_out		=> serial_a,
				parallel_out    => open -- Do not use PO
			);

	-- Parallel In Serial Out a
	PISO_b : shift_register
		port map ( 
				serial_in 		=> '0',
				shift_in 		=> shift_in_ctrl,
				shift_out		=> '0',
				parallel_in		=> b,
				clk 			=> clk,

				serial_out		=> serial_b,
				parallel_out 	=> open
			);

	-- Serial In Parallel Out
	SIPO : shift_register
		port map ( 
				serial_in 		=> serial_sum,
				shift_in 		=> '0', -- Do not use PI mode
				shift_out		=> shift_out_ctrl,
				parallel_in		=> ( others => '0'), -- Do not use PI
				clk 			=> clk,

				serial_out		=> open,
				parallel_out 	=> 	sum
			);

	mode : mode_control
		port map (
			clk					=> clk,

			shift_in_ctrl		=> shift_in_ctrl,
			shift_out_ctrl		=> shift_out_ctrl,
			reset_ctrl			=> reset_ctrl
			);

	bit_adder : full_adder
		port map (
			a_in 				=> serial_a,	
           	b_in 				=> serial_b,
           	carry_in 			=> carry_in,
           	
			sum_out 			=> serial_sum,
           	carry_out 			=> carry_out
		);

end Behavioural;
