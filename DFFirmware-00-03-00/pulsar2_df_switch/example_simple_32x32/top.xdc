# physical constraint (pin location)

# # Pulsar2A 
# set_property PACKAGE_PIN AH4 [get_ports SYSCLK_P]
# set_property PACKAGE_PIN AJ4 [get_ports SYSCLK_N]
# set_property PACKAGE_PIN G12 [get_ports MISO]
# set_property PACKAGE_PIN F16 [get_ports MOSI]
# set_property PACKAGE_PIN H12 [get_ports SPI_SEL]
# set_property PACKAGE_PIN H14 [get_ports SCLK]
# # physical constraint (iostandard)
# set_property IOSTANDARD LVDS [get_ports SYSCLK_P]
# set_property IOSTANDARD LVDS [get_ports SYSCLK_N]
# set_property IOSTANDARD LVCMOS25 [get_ports MISO]
# set_property IOSTANDARD LVCMOS25 [get_ports MOSI]
# set_property IOSTANDARD LVCMOS25 [get_ports SPI_SEL]
# set_property IOSTANDARD LVCMOS25 [get_ports SCLK]

set_property PACKAGE_PIN AU15 [get_ports SYSCLK_P]
set_property PACKAGE_PIN AV15 [get_ports SYSCLK_N]
set_property PACKAGE_PIN BC24 [get_ports MISO]
set_property PACKAGE_PIN BC25 [get_ports MOSI]
set_property PACKAGE_PIN BD26 [get_ports SPI_SEL]
set_property PACKAGE_PIN AV23 [get_ports SCLK]

set_property IOSTANDARD LVDS [get_ports SYSCLK_P]
set_property IOSTANDARD LVDS [get_ports SYSCLK_N]
set_property DIFF_TERM  TRUE [get_ports SYSCLK_P]
set_property IOSTANDARD LVCMOS18 [get_ports MISO]
set_property IOSTANDARD LVCMOS18 [get_ports MOSI]
set_property IOSTANDARD LVCMOS18 [get_ports SPI_SEL]
set_property IOSTANDARD LVCMOS18 [get_ports SCLK]


# timing constraint
# clock period
create_clock -name sysclk_p_i -period 5      -waveform {0 2.5}   [get_ports SYSCLK_P]
create_clock -name clk50_i    -period 20     -waveform {0 10.0}  [get_pins clock_buffer/U0/mmcm_adv_inst/CLKOUT2]
create_clock -name main_clk_i -period 6.667  -waveform {0 3.333} [get_pins clock_buffer/U0/mmcm_adv_inst/CLKOUT1]

set_false_path -from [get_clocks "clk50_i"] -to [get_clocks "main_clk_i"]
set_false_path -from [get_clocks "main_clk_i"] -to [get_clocks "clk50_i"]
