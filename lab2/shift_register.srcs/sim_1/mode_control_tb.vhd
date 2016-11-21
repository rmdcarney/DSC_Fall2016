----------------------------------------------------------------------------------
-- mode control TB
----------------------------------------------------------------------------------


library IEEE;
USE ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration for your testbench. Don't declare any ports here
entity mode_control_tb IS 
end mode_control_tb;

architecture behavior OF mode_control_tb IS

	-- Component Declaration: Unit Under Test (UUT)
	component mode_control
	port (
			-- Inputs
			clk			: in STD_LOGIC;

			-- Outputs
			shift_in_ctrl	: out STD_LOGIC;
			shift_out_ctrl	: out STD_LOGIC;
			reset_ctrl		: out STD_LOGIC

		);
	end component;

	-- Signal definitions: for each port of uut
	signal reset, shift_in, shift_out	: STD_LOGIC := '0';

	-- Clock definitions
	signal clk							: STD_LOGIC := '0';
	constant clk_period					: time := 10 ns;

	begin

		--Clock process
		clk_process : process
		begin
			clk <= not( clk );
			wait for clk_period/2;
		end process;

		-- Instatiate the UUT
		uut: mode_control
			port MAP (

				clk => clk, shift_in_ctrl => shift_in, shift_out_ctrl => shift_out, reset_ctrl => reset

				);
				

end;






