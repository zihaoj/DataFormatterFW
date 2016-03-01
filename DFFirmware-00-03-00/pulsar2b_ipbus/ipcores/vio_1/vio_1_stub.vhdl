-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.1 (lin64) Build 881834 Fri Apr  4 13:56:21 MDT 2014
-- Date        : Fri May  9 10:45:08 2014
-- Host        : nuhep-65.phys.northwestern.edu running 64-bit CentOS release 6.5 (Final)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/xilinx/pulsarVivado_2_cleaned/pulsar/implementationPulsar2b/dummy/my_project.srcs/sources_1/ip/vio_1/vio_1_stub.vhdl
-- Design      : vio_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_1 is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end vio_1;

architecture stub of vio_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[0:0],probe_out0[0:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "vio,Vivado 2014.1";
begin
end;
