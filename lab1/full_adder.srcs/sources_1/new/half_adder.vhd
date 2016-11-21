----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2016 05:08:44 PM
-- Design Name: 
-- Module Name: half_adder - Behavioral
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

entity half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

    -- AND 
    component and_gate
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               q : out STD_LOGIC
              );
    end component;
    
    -- XOR
    component xor_gate
        Port ( xor_in_a : in STD_LOGIC;
               xor_in_b : in STD_LOGIC;
               xor_out : out STD_LOGIC
             );
    end component;
    
    
    -- What is this called? Linking?
    for all : and_gate use entity work.and_gate;
    for all : xor_gate use entity work.xor_gate;        
        
begin
    
    -- Instatiate and connect up the entities
    HA_and: and_gate
        port map ( a => a, b => b, q => carry );
    HA_xor: xor_gate
        port map ( xor_in_a => a, xor_in_b => b, xor_out => sum );
        
end Behavioral;
