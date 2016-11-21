----------------------------------------------------------------------------------
-- SR TB
----------------------------------------------------------------------------------


library IEEE;
USE ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration for your testbench. Don't declare any ports here
entity shift_register_tb IS 
end shift_register_tb;

architecture behavior OF shift_register_tb IS

	-- Component Declaration: Unit Under Test (UUT)
	component shift_register
    Port ( 	           	
			-- Single-bit inputs
			serial_in 		: in STD_LOGIC;
			shift_in 		: in STD_LOGIC;
           	shift_out 		: in STD_LOGIC;	
			parallel_in 	: in STD_LOGIC_VECTOR ( 3 downto 0);
			clk 			: in STD_LOGIC;
			reset 			: in STD_LOGIC;

			-- Single-bit outputs
			serial_out 		: out STD_LOGIC;
           	parallel_out 	: out STD_LOGIC_VECTOR ( 3 downto 0)
		 );
    end component;

   	--Signal definitions: Declare (and initialize) a signal for each port of the UUT. 
    signal reset 						: STD_LOGIC := '0';
    signal serial_in, serial_out 		: STD_LOGIC := '0';
    signal shift_in, shift_out 			: STD_LOGIC := '0';
    signal parallel_in, parallel_out 	: STD_LOGIC_VECTOR ( 3 downto 0 ) := (others => '0');
    
    -- Clock definitions
    signal clk							: std_logic := '0';
    constant clk_period 				: time := 10 ns;

begin

   -- Clock process (toggle clock after each half period)
   clk_process :process
   begin
        clk <= not(clk);
        wait for clk_period/2;
   end process;

  
	-- Instantiate the Unit Under Test (UUT).
   uut: shift_register 
   		port MAP (

        	clk => clk, reset => reset, 
			serial_in => serial_in, serial_out => serial_out,
			shift_in => shift_in, shift_out => shift_out,
			parallel_in => parallel_in, parallel_out => parallel_out
			
			);       

   -- Stimulus process
  stim_proc: process
   begin         
        
   			parallel_in <= "1111";

        wait for clk_period;

			shift_in <= '1';
        
        wait for clk_period;
			shift_in <= '0';
        
        
        wait for clk_period;
			

		wait for clk_period;
		wait for clk_period;
        wait for clk_period;
        wait for clk_period;
        wait for clk_period;
                        
			shift_in <= '1';
			shift_out <= '1';

        wait for clk_period;
                
			shift_in <= '0';
			shift_out <= '0';
        
		wait for clk_period;
		
			parallel_in <= "0101";
			shift_in <= '1';

        wait for clk_period;
			
			shift_in <= '0';
        
		wait for clk_period;
			
			shift_out <= '1';
		
        wait for clk_period;
			
			shift_out <= '0';
			parallel_in <= "1111";
			shift_in <= '1';
        
		wait for clk_period;
			
			shift_in <= '0';

		wait for clk_period;
        wait for clk_period;
		
			shift_out <= '1';
        wait for clk_period;
			
			reset <= '1';
			shift_out <= '0';
        
		wait for clk_period;
			
			reset <= '0';
       wait;
  end process;

end;
