set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 12 [current_design]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list MY_USER_INTERFACE/eth/ipb_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {MY_USER_INTERFACE/buf_selected_fpga[0]} {MY_USER_INTERFACE/buf_selected_fpga[1]} {MY_USER_INTERFACE/buf_selected_fpga[2]} {MY_USER_INTERFACE/buf_selected_fpga[3]} {MY_USER_INTERFACE/buf_selected_fpga[4]} {MY_USER_INTERFACE/buf_selected_fpga[5]} {MY_USER_INTERFACE/buf_selected_fpga[6]} {MY_USER_INTERFACE/buf_selected_fpga[7]} {MY_USER_INTERFACE/buf_selected_fpga[8]} {MY_USER_INTERFACE/buf_selected_fpga[9]} {MY_USER_INTERFACE/buf_selected_fpga[10]} {MY_USER_INTERFACE/buf_selected_fpga[11]} {MY_USER_INTERFACE/buf_selected_fpga[12]} {MY_USER_INTERFACE/buf_selected_fpga[13]} {MY_USER_INTERFACE/buf_selected_fpga[14]} {MY_USER_INTERFACE/buf_selected_fpga[15]} {MY_USER_INTERFACE/buf_selected_fpga[16]} {MY_USER_INTERFACE/buf_selected_fpga[17]} {MY_USER_INTERFACE/buf_selected_fpga[18]} {MY_USER_INTERFACE/buf_selected_fpga[19]} {MY_USER_INTERFACE/buf_selected_fpga[20]} {MY_USER_INTERFACE/buf_selected_fpga[21]} {MY_USER_INTERFACE/buf_selected_fpga[22]} {MY_USER_INTERFACE/buf_selected_fpga[23]} {MY_USER_INTERFACE/buf_selected_fpga[24]} {MY_USER_INTERFACE/buf_selected_fpga[25]} {MY_USER_INTERFACE/buf_selected_fpga[26]} {MY_USER_INTERFACE/buf_selected_fpga[27]} {MY_USER_INTERFACE/buf_selected_fpga[28]} {MY_USER_INTERFACE/buf_selected_fpga[29]} {MY_USER_INTERFACE/buf_selected_fpga[30]} {MY_USER_INTERFACE/buf_selected_fpga[31]}]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list CLKBUFFER/inst/FMC_COMMON_CLK]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 4 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/state[0]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/state[1]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/state[2]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/state[3]}]]
create_debug_core u_ila_2 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_2]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_2]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_2]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_2]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_2]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_2]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_2]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_2]
set_property port_width 1 [get_debug_ports u_ila_2/clk]
connect_debug_port u_ila_2/clk [get_nets [list CLKBUFFER/inst/CLK50]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe0]
set_property port_width 5 [get_debug_ports u_ila_2/probe0]
connect_debug_port u_ila_2/probe0 [get_nets [list {MY_DF_MAIN/my_fmc_interface/selected_fmc_fpga_i[0]} {MY_DF_MAIN/my_fmc_interface/selected_fmc_fpga_i[1]} {MY_DF_MAIN/my_fmc_interface/selected_fmc_fpga_i[2]} {MY_DF_MAIN/my_fmc_interface/selected_fmc_fpga_i[3]} {MY_DF_MAIN/my_fmc_interface/selected_fmc_fpga_i[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/output_buf_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/reset_i]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 8 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[0]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[1]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[2]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[3]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[4]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[5]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[6]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_data_in[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 3 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_ctrl_in[0]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_ctrl_in[1]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/sct_ctrl_in[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 32 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[0]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[1]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[2]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[3]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[4]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[5]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[6]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[7]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[8]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[9]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[10]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[11]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[12]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[13]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[14]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[15]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[16]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[17]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[18]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[19]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[20]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[21]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[22]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[23]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[24]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[25]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[26]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[27]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[28]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[29]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[30]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/global_count_buf[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 32 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[0]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[1]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[2]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[3]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[4]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[5]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[6]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[7]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[8]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[9]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[10]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[11]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[12]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[13]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[14]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[15]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[16]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[17]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[18]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[19]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[20]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[21]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[22]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[23]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[24]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[25]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[26]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[27]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[28]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[29]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[30]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/error_count_buf[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 32 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[0]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[1]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[2]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[3]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[4]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[5]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[6]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[7]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[8]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[9]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[10]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[11]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[12]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[13]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[14]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[15]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[16]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[17]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[18]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[19]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[20]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[21]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[22]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[23]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[24]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[25]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[26]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[27]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[28]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[29]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[30]} {MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/correct_count_buf[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
set_property port_width 1 [get_debug_ports u_ila_1/probe6]
connect_debug_port u_ila_1/probe6 [get_nets [list MY_DF_MAIN/my_fmc_interface/FMC_DATA_CHECKER/start]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_ipb_clk]
