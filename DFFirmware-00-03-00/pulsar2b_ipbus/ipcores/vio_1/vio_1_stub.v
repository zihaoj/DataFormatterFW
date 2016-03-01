// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.1 (lin64) Build 881834 Fri Apr  4 13:56:21 MDT 2014
// Date        : Fri May  9 10:45:08 2014
// Host        : nuhep-65.phys.northwestern.edu running 64-bit CentOS release 6.5 (Final)
// Command     : write_verilog -force -mode synth_stub
//               /home/xilinx/pulsarVivado_2_cleaned/pulsar/implementationPulsar2b/dummy/my_project.srcs/sources_1/ip/vio_1/vio_1_stub.v
// Design      : vio_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "vio,Vivado 2014.1" *)
module vio_1(clk, probe_in0, probe_out0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[0:0],probe_out0[0:0]" */;
  input clk;
  input [0:0]probe_in0;
  output [0:0]probe_out0;
endmodule
