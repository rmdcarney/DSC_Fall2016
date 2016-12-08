--------------------------------
-- 16b synchronus counter tb
--------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

-- tb entity
entity signed_nbitCounter_tb is
end signed_nbitCounter_tb;

architecture testbench of signed_nbitCounter_tb is

	-- Repeat N values of B
	function repeat(N: natural; B: std_logic) return std_logic_vector
		is
			variable result: std_logic_vector(1 to N);
			begin
				for i in 1 to N loop
					result(i) := B;
				end loop;
			return result;
	end;

	-- Signals
	signal clk				: STD_LOGIC := '0';
	constant clk_period		: time		:= 10 ns;
	constant numBits		: integer 	:= 8;

	signal	reset			: STD_LOGIC	:= '0';
	signal	value			: STD_LOGIC_VECTOR( numBits-1 downto 0 ) := "10011101";

	-- uut	
	component signed_nbitCounter 
		generic(   nbits : integer := 8; -- variable number of bits
                   upperBound : signed := "01111111"; -- Use full range of counter by default
                   lowerBound : signed := "10000000");
		port (
			-- inputs
			reset	: in STD_LOGIC;
			clk		: in STD_LOGIC;

			value	: out STD_LOGIC_VECTOR( nbits-1 downto 0 )
		);
	end component;

begin 

	--Clk process
	clk_process : process
	begin
		clk <= NOT( clk );
		wait for clk_period/2;
	end process;

	-- uut
	uut : signed_nbitCounter
	    generic map( nbits => numBits, upperBound => "01100100", lowerBound => "10011101" ) -- -100
		port map( clk => clk, reset => reset, value => value );

	-- Stimulus
	stimulus : process
	begin
		
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait for clk_period*30;
		wait;
	end process;
end;
