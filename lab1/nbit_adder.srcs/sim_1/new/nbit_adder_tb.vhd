----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2016 04:33:57 PM
-- Design Name: 
-- Module Name: nbit_adder_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
USE ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration for your testbench. Don't declare any ports here
ENTITY nbit_adder_tb IS 
END nbit_adder_tb;

ARCHITECTURE behavior OF nbit_adder_tb IS

    constant nbits_tb : integer := 2;
   -- Component Declaration: Unit Under Test (UUT)
    COMPONENT nbit_adder
    	generic ( nbits: integer := 4 );

		Port ( 	a_in : in STD_LOGIC_VECTOR ( nbits-1 downto 0);
        	   	b_in : in STD_LOGIC_VECTOR ( nbits-1 downto 0);
           		sum_out : out STD_LOGIC_VECTOR ( nbits-1 downto 0);
           		carry_in : in STD_LOGIC;
           		carry_out : out STD_LOGIC	
		 	);
    END COMPONENT;

   --Signal definitions: Declare (and initialize) a signal for each port of the UUT. 
    signal a_in, b_in, sum_out: STD_LOGIC_VECTOR ( nbits_tb-1 downto 0 ) := (others => '0');
    signal  carry_in, carry_out: STD_LOGIC := '0';
    
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
   
   uut: nbit_adder 
		generic map ( nbits => nbits_tb )
   		PORT MAP (
        	a_in => a_in, b_in => b_in, carry_in => carry_in ,sum_out => sum_out, carry_out => carry_out
			);       

   -- Stimulus process
  stim_proc: process
   begin         
        wait for clk_period;

                a_in <= "00";
                b_in <= "00";
                carry_in <= '0';
        
        wait for clk_period;
        
                a_in <= "01";
                b_in <= "00";
                carry_in <= '0';

        
        wait for clk_period;
                        
                a_in <= "11";
                b_in <= "10";
                carry_in <= '0';
 
        wait for clk_period;
                                       
                a_in <= "11";
                b_in <= "11";
                carry_in <= '0';

        
        wait for clk_period;
                
									a_in <= "00";
									b_in <= "00";
                                carry_in <= '1';
                        
                        wait for clk_period;
                        
                                a_in <= "01";
                                b_in <= "00";
                                carry_in <= '1';
                        
                        wait for clk_period;
                                        
                                a_in <= "11";
                                b_in <= "10";
                                carry_in <= '1';
                                
                        wait for clk_period;
                                                       
                                a_in <= "11";
                                b_in <= "11";
                                carry_in <= '1';
                
        wait for clk_period;
                
                a_in <= "00";
                b_in <= "00";
                 carry_in <= '1';

       wait;
  end process;

END;
