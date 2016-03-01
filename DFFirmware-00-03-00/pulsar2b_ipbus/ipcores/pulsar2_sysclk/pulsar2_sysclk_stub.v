// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.1 (win64) Build 881834 Fri Apr  4 14:15:54 MDT 2014
// Date        : Fri Apr 25 15:53:23 2014
// Host        : PC-UC-FTK-FW running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/cygwin64/home/okumura/firmware_vivado/ipcore/xc7k325t-ffg900-2/pulsar2_sysclk/pulsar2_sysclk_stub.v
// Design      : pulsar2_sysclk
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pulsar2_sysclk(clk_in1_p, clk_in1_n, FMC_COMMON_CLK, MAIN_LOGIC_CLK, CLK50, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1_p,clk_in1_n,FMC_COMMON_CLK,MAIN_LOGIC_CLK,CLK50,reset,locked" */;
  input clk_in1_p;
  input clk_in1_n;
  output FMC_COMMON_CLK;
  output MAIN_LOGIC_CLK;
  output CLK50;
  input reset;
  output locked;
endmodule
