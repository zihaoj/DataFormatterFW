-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
-- Date        : Tue Feb 23 09:43:31 2016
-- Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/pulsar2_sysclk_125/pulsar2_sysclk_125_stub.vhdl
-- Design      : pulsar2_sysclk_125
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulsar2_sysclk_125 is
  Port ( 
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC;
    FMC_COMMON_CLK : out STD_LOGIC;
    MAIN_LOGIC_CLK : out STD_LOGIC;
    CLK50 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );

end pulsar2_sysclk_125;

architecture stub of pulsar2_sysclk_125 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1_p,clk_in1_n,FMC_COMMON_CLK,MAIN_LOGIC_CLK,CLK50,reset,locked";
begin
end;
