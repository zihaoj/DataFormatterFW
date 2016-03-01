set_false_path -through [get_nets rst_*]
set_false_path -through [get_nets clocks/nuke_i]


#MGTREFCLK1_P/N from pag 13 Pulsar 2a schematics
#set_property PACKAGE_PIN G8 [get_ports gt_clkp]
#set_property PACKAGE_PIN G7 [get_ports gt_clkn]
#MGTREFCLK1_P/N from pag 12 Pulsar 2b schematics
set_property PACKAGE_PIN E10 [get_ports gt_clkp]
set_property PACKAGE_PIN E9 [get_ports gt_clkn]
#set_property IOSTANDARD LVDS [get_ports gt_clkp]
#set_property IOSTANDARD LVDS [get_ports gt_clkn]
#set_property DIFF_TERM TRUE [get_ports gt_clkp] #doesn't go through IBUF so no DIFFTERM http://forums.xilinx.com/t5/Spartan-Family-FPGAs/How-do-I-know-if-DIFF-TERM-is-set-to-be-TRUE-correctly/td-p/168044





# GTH to fabric
set_property LOC GTHE2_CHANNEL_X1Y33 [get_cells eth/phy/U0/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/gthe2_i]


set_property PACKAGE_PIN AU15 [get_ports sys_clk_p]
set_property PACKAGE_PIN AV15 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS [get_ports sys_clk_p]
set_property IOSTANDARD LVDS [get_ports sys_clk_n]
set_property DIFF_TERM TRUE [get_ports sys_clk_p]



# LEDs
set_property PACKAGE_PIN AJ30 [get_ports leds[0]]
set_property IOSTANDARD LVCMOS18 [get_ports leds[0]]
set_property PACKAGE_PIN AK33 [get_ports leds[1]]
set_property IOSTANDARD LVCMOS18 [get_ports leds[1]] 
set_property PACKAGE_PIN AJ32 [get_ports leds[2]] 
set_property IOSTANDARD LVCMOS18 [get_ports leds[2]] 
set_property PACKAGE_PIN AJ31 [get_ports leds[3]] 
set_property IOSTANDARD LVCMOS18 [get_ports leds[3]] 


# CLOCK
create_clock -name sys_clk -period 5 -waveform {0 2.5} [get_ports sys_clk_p]
create_clock -name gt_clk -period 8 -waveform {0 4} [get_ports gt_clkp]
#create_clock -name clk125_fr -period 8 -waveform {0 4} [get_nets clk125_fr]
#create_clock -name clk125 -period 8 -waveform {0 4} [get_nets clk125]

create_clock -name eth_txoutclk -period 16.0 -waveform {0.00000 8.00000}  [get_pins eth/phy/U0/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/gthe2_i/TXOUTCLK]
create_clock -name eth_rxoutclk -period 16.0 -waveform {0.00000 8.00000}  [get_pins eth/phy/U0/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/gthe2_i/RXOUTCLK]
create_clock -name clk125_fr    -period 8.0  -waveform {0.00000 4.00000}  [get_pins eth/bufg_fr/O]
create_clock -name clk125       -period 8.0  -waveform {0.00000 4.00000}  [get_pins eth/bufg_125/O]
create_clock -name CLKFBIN      -period 16.0 -waveform {0.00000 8.00000}  [get_pins eth/mcmm/CLKFBOUT]
create_clock -name n_4_mcmm     -period 16.0 -waveform {0.00000 8.00000}  [get_pins eth/mcmm/CLKOUT1]
create_clock -name n_6_mcmm     -period 8.0  -waveform {0.00000 4.00000}  [get_pins eth/mcmm/CLKOUT2]
create_clock -name n_8_mcmm     -period 32.0 -waveform {0.00000 16.00000} [get_pins eth/mcmm/CLKOUT3]
create_clock -name CLKFBIN_1    -period 8.0  -waveform {0.00000 4.00000}  [get_pins clocks/mmcm/CLKFBOUT]
create_clock -name CLKOUT1      -period 32.0 -waveform {0.00000 16.00000} [get_pins clocks/mmcm/CLKOUT1]

create_clock -name clk200_i     -period 5.0  -waveform {0.00000 2.5000}   [get_pins clkbuffer/U0/mmcm_adv_inst/CLKOUT0]
create_clock -name clk50_i      -period 20   -waveform {0.00000 10.0000}  [get_pins clkbuffer/U0/mmcm_adv_inst/CLKOUT2]


set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "clk125_fr"]

set_false_path -from [get_clocks "n_4_mcmm"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "n_4_mcmm"]

set_false_path -from [get_clocks "n_6_mcmm"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "n_6_mcmm"]

set_false_path -from [get_clocks "n_8_mcmm"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "n_8_mcmm"]

set_false_path -from [get_clocks "n_4_mcmm"] -to [get_clocks "clk125_fr"]
set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "n_4_mcmm"]

set_false_path -from [get_clocks "n_6_mcmm"] -to [get_clocks "clk125_fr"]
set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "n_6_mcmm"]

set_false_path -from [get_clocks "n_8_mcmm"] -to [get_clocks "clk125_fr"]
set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "n_8_mcmm"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "clk125_fr"]
set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "clk125_fr"]

set_false_path -from [get_clocks "clk125"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "clk125"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "n_4_mcmm"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "n_4_mcmm"]

set_false_path -from [get_clocks "n_6_mcmm"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "n_6_mcmm"]

set_false_path -from [get_clocks "n_8_mcmm"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "n_8_mcmm"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "eth_txoutclk"]
set_false_path -from [get_clocks "eth_txoutclk"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "eth_rxoutclk"]
set_false_path -from [get_clocks "eth_rxoutclk"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "clk125"] -to [get_clocks "eth_txoutclk"]
set_false_path -from [get_clocks "eth_txoutclk"] -to [get_clocks "clk125"]

set_false_path -from [get_clocks "clk125"] -to [get_clocks "eth_rxoutclk"]
set_false_path -from [get_clocks "eth_rxoutclk"] -to [get_clocks "clk125"]

set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "eth_txoutclk"]
set_false_path -from [get_clocks "eth_txoutclk"] -to [get_clocks "clk125_fr"]

set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "eth_rxoutclk"]
set_false_path -from [get_clocks "eth_rxoutclk"] -to [get_clocks "clk125_fr"]

set_false_path -from [get_clocks "n_4_mcmm"] -to [get_clocks "sys_clk"]
set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "n_4_mcmm"]

set_false_path -from [get_clocks "n_6_mcmm"] -to [get_clocks "sys_clk"]
set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "n_6_mcmm"]

set_false_path -from [get_clocks "n_8_mcmm"] -to [get_clocks "sys_clk"]
set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "n_8_mcmm"]




set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "clk200_i"]
set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "clk125_fr"]

set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "clk200_i"]

set_false_path -from [get_clocks "n_4_mcmm"] -to [get_clocks "clk200_i"]
set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "n_4_mcmm"]

set_false_path -from [get_clocks "n_6_mcmm"] -to [get_clocks "clk200_i"]
set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "n_6_mcmm"]

set_false_path -from [get_clocks "n_8_mcmm"] -to [get_clocks "clk200_i"]
set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "n_8_mcmm"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "clk200_i"]
set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "clk200_i"]

set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "eth_txoutclk"]
set_false_path -from [get_clocks "eth_txoutclk"] -to [get_clocks "clk200_i"]

set_false_path -from [get_clocks "clk200_i"] -to [get_clocks "eth_rxoutclk"]
set_false_path -from [get_clocks "eth_rxoutclk"] -to [get_clocks "clk200_i"]

set_false_path -from [get_clocks "clk125_fr"] -to [get_clocks "clk50_i"]
set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "clk125_fr"]

set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "clk125"]
set_false_path -from [get_clocks "clk125"] -to [get_clocks "clk50_i"]

set_false_path -from [get_clocks "n_4_mcmm"] -to [get_clocks "clk50_i"]
set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "n_4_mcmm"]

set_false_path -from [get_clocks "n_6_mcmm"] -to [get_clocks "clk50_i"]
set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "n_6_mcmm"]

set_false_path -from [get_clocks "n_8_mcmm"] -to [get_clocks "clk50_i"]
set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "n_8_mcmm"]

set_false_path -from [get_clocks "sys_clk"] -to [get_clocks "clk50_i"]
set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "sys_clk"]

set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "CLKOUT1"]
set_false_path -from [get_clocks "CLKOUT1"] -to [get_clocks "clk50_i"]

set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "eth_txoutclk"]
set_false_path -from [get_clocks "eth_txoutclk"] -to [get_clocks "clk50_i"]

set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "eth_rxoutclk"]
set_false_path -from [get_clocks "eth_rxoutclk"] -to [get_clocks "clk50_i"]
