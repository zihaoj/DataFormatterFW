// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Tue Feb 23 09:45:43 2016
// Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/pulsar2_simple_dpram_w36_d1024/pulsar2_simple_dpram_w36_d1024_stub.v
// Design      : pulsar2_simple_dpram_w36_d1024
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_0,Vivado 2015.3" *)
module pulsar2_simple_dpram_w36_d1024(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[9:0],dina[35:0],clkb,addrb[9:0],doutb[35:0]" */;
  input clka;
  input [0:0]wea;
  input [9:0]addra;
  input [35:0]dina;
  input clkb;
  input [9:0]addrb;
  output [35:0]doutb;
endmodule
