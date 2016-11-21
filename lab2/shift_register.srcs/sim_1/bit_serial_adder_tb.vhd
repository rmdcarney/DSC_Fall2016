----------------------------------------------------------------------------------
-- mode control TB
----------------------------------------------------------------------------------


library IEEE;
USE ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration for your testbench. Don't declare any ports here
entity bit_serial_adder_tb IS 
end bit_serial_adder_tb;

architecture behavior OF bit_serial_adder_tb IS

	-- Component Declaration: Unit Under Test (UUT)
	component bit_serial_adder
	port (
			-- Inputs
			a		: in STD_LOGIC_VECTOR ( 3 downto 0 );
			b		: in STD_LOGIC_VECTOR ( 3 downto 0 );
			clk     : in STD_LOGIC;

			-- Outputs
			sum		: out STD_LOGIC_VECTOR (3 downto 0 )

		);
	end component;

	-- Signal definitions: for each port of uut
	signal a, b, sum	: STD_LOGIC_VECTOR (3 downto 0 ) := "0000";

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
		uut: bit_serial_adder
			port MAP (

				clk => clk, a => a, b => b, sum => sum

				);
	stim_proc: process

	begin
			
		a <= "1111";
		b <= "0001";
        
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		a <= "0000";
		b <= "0000";
		wait for clk_period;
        wait for clk_period;
        wait for clk_period;
		wait for clk_period;
        wait for clk_period;
        wait for clk_period;
		wait for clk_period;
        wait for clk_period;
        wait for clk_period;
		wait for clk_period;

		a <= "0000";
		b <= "0000";

		wait;
	end process;
		
end;






