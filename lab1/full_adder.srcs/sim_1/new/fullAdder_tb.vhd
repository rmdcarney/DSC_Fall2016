--
-- VHDL template for creating test benches
--

-- Library declarations: Add/change as needed
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

-- entity declaration for your testbench. Don't declare any ports here
ENTITY fullAdder_tb IS 
END fullAdder_tb;

ARCHITECTURE behavior OF fullAdder_tb IS
   -- Component Declaration: Unit Under Test (UUT)
    COMPONENT full_adder
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               carry_in : in STD_LOGIC;
               sum : out STD_LOGIC;
               carry_out : out STD_LOGIC
              );
    END COMPONENT;

   --Signal definitions: Declare (and initialize) a signal for each port of the UUT. 
    signal a, b, carry_in, sum, carry_out: std_logic := '0';
    
    -- Clock definitions
    signal clk: std_logic := '0';
    constant clk_period : time := 10 ns;

BEGIN

   -- Clock process (toggle clock after each half period)
   clk_process :process
   begin
        clk <= not(clk);
        wait for clk_period/2;
   end process;

  
-- Instantiate the Unit Under Test (UUT).
-- In the port map, connect with the coresponding signals you declared above. 
   
   uut: full_adder PORT MAP (

        a => a, b => b, carry_in => carry_in ,sum => sum, carry_out => carry_out

    );       

   -- Stimulus process
  stim_proc: process
   begin         
        wait for clk_period;

                a <= '0';
                b <= '0';
                carry_in <= '0';
        
        wait for clk_period;
        
                a <= '1';
                b <= '0';
                carry_in <= '0';

        
        wait for clk_period;
                        
                a <= '0';
                b <= '1';
                carry_in <= '0';
 
        wait for clk_period;
                                       
                a <= '1';
                b <= '1';
                carry_in <= '0';

        
        wait for clk_period;
                
                                a <= '0';
                                b <= '0';
                                carry_in <= '1';
                        
                        wait for clk_period;
                        
                                a <= '1';
                                b <= '0';
                                carry_in <= '1';
                        
                        wait for clk_period;
                                        
                                a <= '0';
                                b <= '1';
                                carry_in <= '1';
                                
                        wait for clk_period;
                                                       
                                a <= '1';
                                b <= '1';
                                carry_in <= '1';
                
        wait for clk_period;
                
                a <= '0';
                b <= '0';
                 carry_in <= '1';

       wait;
  end process;

END;
