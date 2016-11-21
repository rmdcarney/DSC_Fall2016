----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2016 05:06:45 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           carry_in : in STD_LOGIC;
           sum : out STD_LOGIC;
           carry_out : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

-- OR
    component or_gate
        Port ( or_in_a : in STD_LOGIC;
               or_in_b : in STD_LOGIC;
               or_out : out STD_LOGIC
             );
    end component;
    
    -- Half-adder
    component half_adder
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               sum : out STD_LOGIC;
               carry : out STD_LOGIC);
    end component;
    
    for all : half_adder use entity work.half_adder;
    for all : or_gate use entity work.or_gate;
    
    -- Internal signals
    signal mid_sum, mid_carry_a, mid_carry_b: std_logic; 
    
begin

     HA_input: half_adder
        port map ( a => a, b => b, sum =>mid_sum, carry => mid_carry_a  );
     HA_carry: half_adder
        port map ( a => carry_in, b => mid_sum, sum => sum, carry => mid_carry_b );
     or_gate_carry: or_gate 
        port map ( or_in_a => mid_carry_a, or_in_b => mid_carry_b, or_out => carry_out);

end Behavioral;
