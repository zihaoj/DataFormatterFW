// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Tue Feb 23 09:46:16 2016
// Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/XFIFOLSC/XFIFOLSC_stub.v
// Design      : XFIFOLSC
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_0_0,Vivado 2015.3" *)
module XFIFOLSC(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, empty, wr_data_count)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[33:0],wr_en,rd_en,dout[33:0],full,empty,wr_data_count[8:0]" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [33:0]din;
  input wr_en;
  input rd_en;
  output [33:0]dout;
  output full;
  output empty;
  output [8:0]wr_data_count;
endmodule
