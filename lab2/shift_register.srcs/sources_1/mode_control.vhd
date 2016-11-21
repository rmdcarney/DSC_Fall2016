----------------------------------------------------------------------------------
--- MODE control for SR
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mode_control is

	port (
			-- Inputs
			clk			: in STD_LOGIC;

			-- Outputs
			shift_in_ctrl	: out STD_LOGIC;
			shift_out_ctrl	: out STD_LOGIC;
			reset_ctrl		: out STD_LOGIC

		);

end mode_control;

architecture Behavioural of mode_control is

	signal state 	: STD_LOGIC_VECTOR ( 1 downto 0 );
	-- Define type to make FSM more readable
	--type state_type is ( RESET, );
    --signal state : state_type;

begin

	process ( clk, state )
	begin

		if rising_edge( clk ) then
			
			case state is 
				when "00" =>
					
					state 			<= "01";
					reset_ctrl 		<= '1';
					shift_in_ctrl 	<= '1';
					shift_out_ctrl 	<= '0';

				when "01" =>
					
					reset_ctrl 		<= '0';
					shift_in_ctrl 	<= '0';
					shift_out_ctrl 	<= '1';
					state 			<=  "10";
				
				when "10" => 
					
					reset_ctrl 		<= '0';
					shift_in_ctrl 	<= '0';
					shift_out_ctrl 	<= '0';
					state 			<= "11";

				when others  =>

					reset_ctrl 		<= '0';
					shift_in_ctrl 	<= '0';
					shift_out_ctrl 	<= '0';
					state <= "00";

				end case;
			end if; --clk 
		end process;

	end Behavioural;





