// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Tue Feb 23 09:43:31 2016
// Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/pulsar2_sysclk_125/pulsar2_sysclk_125_stub.v
// Design      : pulsar2_sysclk_125
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pulsar2_sysclk_125(clk_in1_p, clk_in1_n, FMC_COMMON_CLK, MAIN_LOGIC_CLK, CLK50, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1_p,clk_in1_n,FMC_COMMON_CLK,MAIN_LOGIC_CLK,CLK50,reset,locked" */;
  input clk_in1_p;
  input clk_in1_n;
  output FMC_COMMON_CLK;
  output MAIN_LOGIC_CLK;
  output CLK50;
  input reset;
  output locked;
endmodule
