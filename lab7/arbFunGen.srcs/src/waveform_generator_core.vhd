---------------------------------------
-- Waveform gen. core
---------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

-- entity declaration
entity waveformGen_core is

	-- TODO Make generic for frequency
	port(
			-- Wave selection switches (could be switched to button press)
			select_square 	: in STD_LOGIC;
			select_triangle	: in STD_LOGIC;
			select_sine		: in STD_LOGIC;
			select_sawtooth	: in STD_LOGIC;
			
			clk				: in STD_LOGIC;
			x				: in STD_LOGIC_VECTOR( 7 downto 0 );
			fx				: out STD_LOGIC_VECTOR( 7 downto 0 )
		);

end waveformGen_core;

architecture waveform_generator of waveformGen_core is 

    -- Signals
	signal sine_out			: STD_LOGIC_VECTOR( 15 downto 0 );

	-- Square wave
	function squareWave( x : STD_LOGIC_VECTOR( 7 downto 0 )) 
	return STD_LOGIC_VECTOR is
		
		variable result : STD_LOGIC_VECTOR( 7 downto 0 );

		begin
			if signed(x) < 0 then
				result := "00000000";
			else
				result := "11111111";
			end if;
		return result;
	end; -- square

	-- Sawtooth wave
	function sawtoothWave( x : STD_LOGIC_VECTOR( 7 downto 0 ))
	return STD_LOGIC_VECTOR is

		variable result 	: signed( 7 downto 0 );
		constant maxValue	: signed( 7 downto 0 ) := "01100100";

		begin 
			if signed(x) < 0 then
				result := maxValue + signed(x);
			else
				result := signed(x);
			end if;
		return STD_LOGIC_VECTOR(result);
	end; -- sawtooth

	-- Triangle wave
	function triangleWave( x : STD_LOGIC_VECTOR( 7 downto 0 ))
	return STD_LOGIC_VECTOR is

		variable result 	: signed( 7 downto 0 );
		constant maxValue	: signed( 7 downto 0 ) := "01100100";

		begin 
			if signed(x) < 0 then
				result := maxValue + signed(x);
			else
				result := maxValue - signed(x);
			end if;
		return STD_LOGIC_VECTOR(result);
	end; -- triangle

	function sineWave( sine_out : STD_LOGIC_VECTOR( 15 downto 0 ))
	return STD_LOGIC_VECTOR is
		
		variable result		: STD_LOGIC_VECTOR( 7 downto 0 );
		variable cordicOut	: signed( 15 downto 0);		

		begin
			result := sine_out(15 downto 8);
			if result < 0 then
				result := 64 + result;
				if result < 0 then
					result := ( others => '0' );
				end if;
			else
				result := STD_LOGIC_VECTOR(result) + 64;
			end if;
		return STD_LOGIC_VECTOR(result);
	end;

	-- Rescale
	function rescale( fx : STD_LOGIC_VECTOR( 7 downto 0 ))
	return STD_LOGIC_VECTOR is

		variable result 	: STD_LOGIC_VECTOR(7 downto 0);
		constant maxValue	: STD_LOGIC_VECTOR( 7 downto 0 ):= ( others => '0' );

		begin
			if fx = "10000000" then
				result := "11111111";
			else
				result := fx(6 downto 0) & '0';
			end if;
		return STD_LOGIC_VECTOR(result);
	end;
	
	--Component
	component sinusoidal_gen
 		port (
  			aclk 				: in STD_LOGIC;
    		s_axis_phase_tvalid : in STD_LOGIC;
   			s_axis_phase_tdata 	: in STD_LOGIC_VECTOR(7 downto 0);
   			m_axis_dout_tvalid 	: out STD_LOGIC;
    		m_axis_dout_tdata 	: out STD_LOGIC_VECTOR(15 downto 0)
  		);
	end component; 

	

begin

	genWave : process( clk, select_square, select_triangle, select_sine, select_sawtooth )
	begin
		if rising_edge( clk ) then
			if select_square = '1' then
				fx <= squareWave( x );
			elsif select_triangle = '1' then
				fx <= rescale(triangleWave( x ));
			elsif select_sine = '1' then
				fx <= rescale(sineWave(sine_out));
			end if;
		end if;
	end process;

	-- sine
	sine_gen : sinusoidal_gen
		port map( 
    		aclk => clk,
    		s_axis_phase_tvalid => '1',
    		s_axis_phase_tdata => x,
    		m_axis_dout_tvalid => open,
    		m_axis_dout_tdata => sine_out
  		); 

end waveform_generator;
