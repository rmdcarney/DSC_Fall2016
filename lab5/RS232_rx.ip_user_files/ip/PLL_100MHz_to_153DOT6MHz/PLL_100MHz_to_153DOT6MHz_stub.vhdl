-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Thu Dec  8 10:54:59 2016
-- Host        : el-02.physto.se running 64-bit CentOS release 6.3 (Final)
-- Command     : write_vhdl -force -mode synth_stub
--               /nfs/home/rcarney/vhdl/lab5/RS232_rx.srcs/sources_1/ip/PLL_100MHz_to_153DOT6MHz/PLL_100MHz_to_153DOT6MHz_stub.vhdl
-- Design      : PLL_100MHz_to_153DOT6MHz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLL_100MHz_to_153DOT6MHz is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC
  );

end PLL_100MHz_to_153DOT6MHz;

architecture stub of PLL_100MHz_to_153DOT6MHz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clk_out1,locked";
begin
end;
