set work work

vlib work

vdel -lib work -all

vcom -dbg -work work ../../pulsar2_fmc_interface_v2/fmcLib.2A.vhd
vcom -dbg -work work ../../ipcore_vc7k325t/pulsar2_fifo_w36_d1024_fwft.vhd
vcom -dbg -work work ../fmc_input_buffer_d1024.vhd

vcom -dbg -work work testbench.vhd
vsim -t 1ps -lib work -L unisim testbench

trace /testbench/*
trace -in  /testbench/myFifo/myFifo/*
trace -out /testbench/myFifo/myFifo/*

run 200us

bye
 
