------------------------------------------------------------------------
--	pmod_da1_ctrl.vhd  --  PmodDA1 Controller
------------------------------------------------------------------------
-- Author: Luke Renaud 
--	Copyright 2011 Digilent, Inc.
------------------------------------------------------------------------
-- Module description
--		This is a simple controller for the Digilent DA1 PMOD module
--		The module receivesin two single-byte data words, and
--		transmits them to the PmodDA1 module when it is brought
--		out of reset. To transmit new settings to the PmodDA1, the
--		Data0 and Data1 words are set, and then the reset signal is set high and then low again.
--              This design sets the two voltage outputs of each DA converter to
--              the same 8-bit value (for reasons of simplicity and speed).
--
--  Inputs:
--		datClk		Data Clock (up to 25 MHz)
--		Data0		Data word for DA #0 channels 1 and 2 (8b)
--		Data1		Data word for DA #1 channels 1 and 2 (8b)
--		rst		Reset (active high)
--
--  Outputs:    
--
--		SD0			Data out to D0
--		SD1			Data out for D1
--		SYNC			Chip Select line to module (active low)
--		DONE			Indicate "done" to top-level design
--
------------------------------------------------------------------------
-- Revision History:
--
--	5/23/2011(Luke Renaud): created
--      17/08/2016(Sam Silverstein): edited for clarity and ease of use
--
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pmodDA1_ctrl is
    Port ( datClk		: in	STD_LOGIC;
           SD0			: out	STD_LOGIC;
           SD1			: out	STD_LOGIC;
           Chan0		: in	STD_LOGIC_VECTOR (7 downto 0);
           Chan1		: in	STD_LOGIC_VECTOR (7 downto 0);
           rst			: in	STD_LOGIC;
	       SYNC		: out	STD_LOGIC;
           DONE		: out	STD_LOGIC);
end pmodDA1_ctrl;

architecture Behavioral of pmodDA1_ctrl is

	------------------------------------------------------------------------
	-- General control and timing signals
	------------------------------------------------------------------------
	type stDACCtrl is (stInit, stTx, stDone); -- States of DA1 state machine
	signal stCur : stDACCtrl := stInit;
 -- Current status
	
	signal index : integer := 0;
	
	------------------------------------------------------------------------
	-- Data path signals
	------------------------------------------------------------------------
    signal  wData0, wData1 : std_logic_vector (15 downto 0);  -- reformatted serial
                                                          -- data to DACs

------------------------------------------------------------------------
-- Implementation
------------------------------------------------------------------------

begin

        -- Reformat input data to 16-bit serial link format
        wData0 <= Chan0(0) & Chan0(1) & Chan0(2) & Chan0(3) & Chan0(4) & Chan0(5) & Chan0(6) & Chan0(7) & "00000000";
        wData1 <= Chan1(0) & Chan1(1) & Chan1(2) & Chan1(3) & Chan1(4) & Chan1(5) & Chan1(6) & Chan1(7) & "00000000";

	-- Send an indexed bit of each word to the two DACs
	SD0 <= wData0(index);
	SD1 <= wData1(index);

	process(rst, datClk)
	begin
		-- Reset Condition
		if falling_edge(datClk) then
		  if (rst = '1') then
			 DONE <= '0';
			 SYNC <= '1';
			 index <= 0;
			 stCur <= stInit;
		  else
			case stCur is
				when stInit =>
					-- Transmit the first bit
					DONE <= '0';
					SYNC <= '0'; -- Set select line low
					index <= 0; -- Initalize the index
					stCur <= stTx;
				when stTx =>
					-- Transmit remaining 15 bits
					DONE <= '0';
					SYNC <= '0';
					index <= index + 1; -- Increment bit index 
					if (index = 14) then -- Stop at the last bit
					-- Start changing the stCur state when
                                        -- index equals 14, so it is "Done"
                                        -- at index 15. 
 						stCur <= stDone;
					else
						stCur <= stTx;
					end if;
				when others => -- Done! To transmit again, reset the module.
					stCur <= stDone;
					DONE <= '1';
					SYNC <= '1';
					index <= 0;
			end case;
		  end if;
		end if;
	end process;


end Behavioral;

