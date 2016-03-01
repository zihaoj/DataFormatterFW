// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Tue Feb 23 09:50:10 2016
// Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/input_mod2idx/input_mod2idx_stub.v
// Design      : input_mod2idx
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_0,Vivado 2015.3" *)
module input_mod2idx(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[13:0],dina[8:0],douta[8:0],clkb,web[0:0],addrb[13:0],dinb[8:0],doutb[8:0]" */;
  input clka;
  input [0:0]wea;
  input [13:0]addra;
  input [8:0]dina;
  output [8:0]douta;
  input clkb;
  input [0:0]web;
  input [13:0]addrb;
  input [8:0]dinb;
  output [8:0]doutb;
endmodule
