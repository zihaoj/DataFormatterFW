-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.1 (win64) Build 881834 Fri Apr  4 14:15:54 MDT 2014
-- Date        : Fri Apr 25 15:53:23 2014
-- Host        : PC-UC-FTK-FW running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/cygwin64/home/okumura/firmware_vivado/ipcore/xc7k325t-ffg900-2/pulsar2_sysclk/pulsar2_sysclk_stub.vhdl
-- Design      : pulsar2_sysclk
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulsar2_sysclk is
  Port ( 
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC;
    FMC_COMMON_CLK : out STD_LOGIC;
    MAIN_LOGIC_CLK : out STD_LOGIC;
    CLK50 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );

end pulsar2_sysclk;

architecture stub of pulsar2_sysclk is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1_p,clk_in1_n,FMC_COMMON_CLK,MAIN_LOGIC_CLK,CLK50,reset,locked";
begin
end;
