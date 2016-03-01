-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
-- Date        : Tue Feb 23 09:46:46 2016
-- Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/output_sctmod2duplication/output_sctmod2duplication_stub.vhdl
-- Design      : output_sctmod2duplication
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output_sctmod2duplication is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 1 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 1 downto 0 );
    clkb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 12 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );

end output_sctmod2duplication;

architecture stub of output_sctmod2duplication is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,wea[0:0],addra[12:0],dina[1:0],douta[1:0],clkb,web[0:0],addrb[12:0],dinb[1:0],doutb[1:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_3_0,Vivado 2015.3";
begin
end;
