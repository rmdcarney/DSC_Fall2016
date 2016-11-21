----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2016 10:19:09 AM
-- Design Name: 
-- Module Name: adder_4b - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_4b is
    Port ( a_in : in STD_LOGIC_VECTOR (3 downto 0);
           b_in : in STD_LOGIC_VECTOR (3 downto 0);
           sum_out : out STD_LOGIC_VECTOR (3 downto 0);
           carry_in : in STD_LOGIC;
           carry_out : out STD_LOGIC);
end adder_4b;

architecture Behavioral of adder_4b is

    component full_adder
    Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               carry_in : in STD_LOGIC;
               sum : out STD_LOGIC;
               carry_out : out STD_LOGIC);
    end component;


    for all : full_adder use entity work.full_adder;
    
    signal carry_01, carry_12, carry_23: STD_LOGIC;
    
begin

    adder_0: full_adder
        port map ( a => a_in(0), b => b_in(0), carry_in => carry_in, sum => sum_out(0), carry_out => carry_01 );
	adder_1: full_adder
		port map ( a => a_in(1), b => b_in(1), carry_in => carry_01, sum => sum_out(1), carry_out => carry_12 );
	adder_2: full_adder
		port map ( a => a_in(2), b => b_in(2), carry_in => carry_12, sum => sum_out(2), carry_out => carry_23 );
	adder_3: full_adder
		port map ( a => a_in(3), b => b_in(3), carry_in => carry_23, sum => sum_out(3), carry_out => carry_out );


end Behavioral;
